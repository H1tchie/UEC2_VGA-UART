`timescale 1 ns / 1 ps

module draw_rect (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,
    input  logic [11:0] rgb_pixel,
    output  logic [11:0] pixel_addr,

    vga_if.out vga_out,
    vga_if.in vga_in   
);

logic [11:0] pixel_addr_nxt;
import vga_pkg::*;
vga_if vga_nxt();


always_ff @(posedge clk) begin
    if (rst) begin
        vga_out.vcount <= 11'b0;
        vga_out.vsync  <= 1'b0;
        vga_out.vblnk  <= 1'b0;
        vga_out.hcount <= 11'b0;
        vga_out.hsync  <= 1'b0;
        vga_out.hblnk  <= 1'b0;
        vga_out.rgb    <= '0;
        pixel_addr     <= '0;
    end else begin
        vga_out.vcount <= vga_in.vcount;
        vga_out.vsync  <= vga_in.vsync;
        vga_out.vblnk  <= vga_in.vblnk;
        vga_out.hcount <= vga_in.hcount;
        vga_out.hsync  <= vga_in.hsync;
        vga_out.hblnk  <= vga_in.hblnk;
        vga_out.rgb    <= vga_nxt.rgb;
        pixel_addr     <= pixel_addr_nxt;
    end
end


always_comb begin
    pixel_addr_nxt = {6'(vga_in.vcount[5:0] - ypos), 6'(vga_in.hcount[5:0] -xpos)};
    if (vga_in.hcount <= xpos + REC_W + 1 && vga_in.hcount > xpos + 1 && vga_in.vcount>=ypos && vga_in.vcount<ypos + REC_H )
        vga_nxt.rgb = rgb_pixel;
    else 
        vga_nxt.rgb = vga_in.rgb;
end


endmodule