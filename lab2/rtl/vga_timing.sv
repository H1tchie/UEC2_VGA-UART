/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Vga timing controller.
 */

`timescale 1 ns / 1 ps

module vga_timing (
    input  logic clk,
    input  logic rst,

    vga_if.out vga_out   
);

import vga_pkg::*;
vga_if vga_nxt();

/**
 * Local variables and signals
 */

/**
 * Internal logic
 */

// Add your code here.

always_ff @(posedge clk) begin
    if(rst) begin
        vga_out.vcount <= 11'b0;
        vga_out.vsync  <= 1'b0;
        vga_out.vblnk  <= 1'b0;
        vga_out.hcount <= 11'b0;
        vga_out.hsync  <= 1'b0;
        vga_out.hblnk  <= 1'b0;
    end
    else begin
        vga_out.vcount <= vga_nxt.vcount;
        vga_out.vsync  <= vga_nxt.vsync;
        vga_out.vblnk  <= vga_nxt.vblnk;
        vga_out.hcount <= vga_nxt.hcount;
        vga_out.hsync  <= vga_nxt.hsync;
        vga_out.hblnk  <= vga_nxt.hblnk;
    end
end

always_comb begin
    if(vga_out.hcount == HOR_MAX-1)begin
        if(vga_out.vcount == VER_MAX-1)begin
            vga_nxt.vcount = 11'b0;
        end
        else begin
            vga_nxt.vcount = vga_out.vcount+ 1;
        end
        vga_nxt.hcount = 11'b0;
    end
    else begin
        vga_nxt.hcount = vga_out.hcount + 1;
        vga_nxt.vcount = vga_out.vcount;
    end


   if(vga_nxt.hcount >= HOR_BLANK_START) begin
    vga_nxt.hblnk = 1'b1;
   end 
   else begin
    vga_nxt.hblnk = 1'b0;
   end

   if((vga_nxt.hcount >= HOR_SYNCH_START) && (vga_nxt.hcount < HOR_SYNCH_STOP)) begin
    vga_nxt.hsync = 1'b1;
   end 
   else begin
    vga_nxt.hsync = 1'b0;
   end

   if(vga_nxt.vcount >= VER_BLANK_START) begin
    vga_nxt.vblnk = 1'b1;
   end 
   else begin
    vga_nxt.vblnk = 1'b0;
   end

   if((vga_nxt.vcount > VER_SYNCH_START-1) && (vga_nxt.vcount < VER_SYNCH_STOP)) begin
    vga_nxt.vsync = 1'b1;
   end 
   else begin
    vga_nxt.vsync = 1'b0;
   end

end

endmodule
