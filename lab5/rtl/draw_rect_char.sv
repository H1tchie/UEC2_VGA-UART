`timescale 1 ns / 1 ps

module draw_rect_char (
    input  logic clk,
    input  logic rst,
    input  logic [7:0] char_pixels,
    output  logic [7:0] char_xy,
    output  logic [3:0] char_line,

    vga_if.out vga_out,
    vga_if.in vga_in   
);



import vga_pkg::*;
vga_if vga_nxt();
localparam RECT_X = 160;
localparam RECT_Y = 45;

logic [10:0] vcount_rect;
logic [10:0] hcount_rect;
logic [7:0] char_xy_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        vga_out.vcount <= 11'b0;
        vga_out.vsync  <= 1'b0;
        vga_out.vblnk  <= 1'b0;
        vga_out.hcount <= 11'b0;
        vga_out.hsync  <= 1'b0;
        vga_out.hblnk  <= 1'b0;
        vga_out.rgb    <= '0;
        char_line      <= 0;
        char_xy        <= 0;
    end else begin
        vga_out.vcount <= vga_in.vcount;
        vga_out.vsync  <= vga_in.vsync;
        vga_out.vblnk  <= vga_in.vblnk;
        vga_out.hcount <= vga_in.hcount;
        vga_out.hsync  <= vga_in.hsync;
        vga_out.hblnk  <= vga_in.hblnk;
        vga_out.rgb    <= vga_nxt.rgb;
        char_line      <= vga_in.vcount[3:0];
        char_xy        <= char_xy_nxt;
    end
end

assign vcount_rect = vga_in.vcount - RECT_Y;
assign hcount_rect = vga_in.hcount - RECT_X;

assign char_xy_nxt = {vcount_rect[7:4], hcount_rect[6:3]};

always_comb begin
    if(vga_in.vcount >= RECT_Y && vga_in.vcount <= 256 + RECT_Y && vga_in.hcount >= RECT_X && vga_in.hcount <= RECT_X + 128) begin
        if(char_pixels[4'b1000-vga_in.hcount[2:0]])
            vga_nxt.rgb[11:0] = 12'hf_0_0;
        else 
            vga_nxt.rgb = vga_in.rgb;
    end
    else
        vga_nxt.rgb = vga_in.rgb;
end


endmodule