`timescale 1 ns / 1 ps

module draw_mouse (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos,
    input  logic [11:0] ypos,

    vga_if.out vga_out,
    vga_if.in vga_in   
);

import vga_pkg::*;
vga_if vga_nxt();

MouseDisplay u_MouseDisplay(
    .pixel_clk(clk),
    .xpos,
    .ypos,

    .blank(vga_in.hblnk | vga_in.vblnk),
    .hcount(vga_in.hcount),
    .vcount(vga_in.vcount),
    .rgb_in(vga_in.rgb),
    .rgb_out(vga_out.rgb)



);

always_ff @(posedge clk) begin
    if (rst) begin
        vga_out.vcount <= 11'b0;
        vga_out.vsync  <= 1'b0;
        vga_out.vblnk  <= 1'b0;
        vga_out.hcount <= 11'b0;
        vga_out.hsync  <= 1'b0;
        vga_out.hblnk  <= 1'b0;
    end else begin
        vga_out.vcount <= vga_in.vcount;
        vga_out.vsync  <= vga_in.vsync;
        vga_out.vblnk  <= vga_in.vblnk;
        vga_out.hcount <= vga_in.hcount;
        vga_out.hsync  <= vga_in.hsync;
        vga_out.hblnk  <= vga_in.hblnk;
    end
end

endmodule