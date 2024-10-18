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
    output logic [10:0] vcount,
    output logic vsync,
    output logic vblnk,
    output logic [10:0] hcount,
    output logic hsync,
    output logic hblnk
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

// Add your signals and variables here.
 logic [10:0] vcount_nxt;
 logic vsync_nxt;
 logic vblnk_nxt;
 logic [10:0] hcount_nxt;
 logic hsync_nxt;
 logic hblnk_nxt;


/**
 * Internal logic
 */

// Add your code here.

always_ff @(posedge clk) begin
    if(rst) begin
        vcount <= 11'b0;
        vsync  <= 1'b0;
        vblnk  <= 1'b0;
        hcount <= 11'b0;
        hsync  <= 1'b0;
        hblnk  <= 1'b0;
    end
    else begin
        vcount <= vcount_nxt;
        vsync  <= vsync_nxt;
        vblnk  <= vblnk_nxt;
        hcount <= hcount_nxt;
        hsync  <= hsync_nxt;
        hblnk  <= hblnk_nxt;
    end
end

always_comb begin
    if(hcount == HOR_MAX-1)begin
        if(vcount == VER_MAX-1)begin
            vcount_nxt = 11'b0;
        end
        else begin
            vcount_nxt = vcount+ 1;
        end
        hcount_nxt = 11'b0;
    end
    else begin
        hcount_nxt = hcount + 1;
        vcount_nxt = vcount;
    end


   if(hcount_nxt >= HOR_BLANK_START) begin
    hblnk_nxt = 1'b1;
   end 
   else begin
    hblnk_nxt = 1'b0;
   end

   if((hcount_nxt >= HOR_SYNCH_START) && (hcount_nxt < HOR_SYNCH_STOP)) begin
    hsync_nxt = 1'b1;
   end 
   else begin
    hsync_nxt = 1'b0;
   end

   if(vcount_nxt >= VER_BLANK_START) begin
    vblnk_nxt = 1'b1;
   end 
   else begin
    vblnk_nxt = 1'b0;
   end

   if((vcount_nxt > VER_SYNCH_START-1) && (vcount_nxt < VER_SYNCH_STOP)) begin
    vsync_nxt = 1'b1;
   end 
   else begin
    vsync_nxt = 1'b0;
   end

end

endmodule
