`timescale 1 ns / 1 ps

module draw_rect (
    input  logic clk,
    input  logic rst,

    vga_if.out vga_out,
    vga_if.in vga_in   
);

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
    end else begin
        vga_out.vcount <= vga_in.vcount;
        vga_out.vsync  <= vga_in.vsync;
        vga_out.vblnk  <= vga_in.vblnk;
        vga_out.hcount <= vga_in.hcount;
        vga_out.hsync  <= vga_in.hsync;
        vga_out.hblnk  <= vga_in.hblnk;
        vga_out.rgb    <= vga_nxt.rgb;
    end
end

always_comb begin
    if (vga_in.hcount < REC_X + REC_W && vga_in.hcount >= REC_X && vga_in.vcount>=REC_Y && vga_in.vcount<REC_Y + REC_H)
        vga_nxt.rgb = REC_C ;
    else 
        vga_nxt.rgb = vga_in.rgb;
end


endmodule