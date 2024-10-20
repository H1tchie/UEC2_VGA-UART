/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Draw background.
 */


`timescale 1 ns / 1 ps

module draw_bg (
    input  logic clk,
    input  logic rst,

    input  logic [10:0] vcount_in,
    input  logic        vsync_in,
    input  logic        vblnk_in,
    input  logic [10:0] hcount_in,
    input  logic        hsync_in,
    input  logic        hblnk_in,

    output logic [10:0] vcount_out,
    output logic        vsync_out,
    output logic        vblnk_out,
    output logic [10:0] hcount_out,
    output logic        hsync_out,
    output logic        hblnk_out,

    output logic [11:0] rgb_out
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

logic [11:0] rgb_nxt;


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
    if (rst) begin
        vcount_out <= '0;
        vsync_out  <= '0;
        vblnk_out  <= '0;
        hcount_out <= '0;
        hsync_out  <= '0;
        hblnk_out  <= '0;
        rgb_out    <= '0;
    end else begin
        vcount_out <= vcount_in;
        vsync_out  <= vsync_in;
        vblnk_out  <= vblnk_in;
        hcount_out <= hcount_in;
        hsync_out  <= hsync_in;
        hblnk_out  <= hblnk_in;
        rgb_out    <= rgb_nxt;
    end
end

always_comb begin : bg_comb_blk
    if (vblnk_in || hblnk_in) begin             // Blanking region:
        rgb_nxt = 12'h0_0_0;                    // - make it it black.
    end else begin                              // Active region:
        if (vcount_in == 0)                     // - top edge:
            rgb_nxt = 12'hf_f_0;                // - - make a yellow line.
        else if (vcount_in == VER_PIXELS - 1)   // - bottom edge:
            rgb_nxt = 12'hf_0_0;                // - - make a red line.
        else if (hcount_in == 0)                // - left edge:
            rgb_nxt = 12'h0_f_0;                // - - make a green line.
        else if (hcount_in == HOR_PIXELS - 1)   // - right edge:
            rgb_nxt = 12'h0_0_f;                // - - make a blue line.

        // Add your code here.

        //Drawing M
        else if (hcount_in <= RIGHT_M_LINE_1 && hcount_in >= LEFT_M_LINE_1 && vcount_in>=TOP_M_LINE_1 && vcount_in<=BOT_M_LINE_1)
            rgb_nxt = 12'h0_0_f;
        else if (hcount_in <= RIGHT_M_LINE_2 && hcount_in >= LEFT_M_LINE_2 && vcount_in>=TOP_M_LINE_2 && vcount_in<=BOT_M_LINE_2)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_M_LINE_3 && hcount_in >= LEFT_M_LINE_3 && vcount_in>=TOP_M_LINE_3 && vcount_in<=BOT_M_LINE_3)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_M_LINE_4 && hcount_in >= LEFT_M_LINE_4 && vcount_in>=TOP_M_LINE_4 && vcount_in<=BOT_M_LINE_4)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_M_LINE_5 && hcount_in >= LEFT_M_LINE_5 && vcount_in>=TOP_M_LINE_5 && vcount_in<=BOT_M_LINE_5)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_M_LINE_6 && hcount_in >= LEFT_M_LINE_6 && vcount_in>=TOP_M_LINE_6 && vcount_in<=BOT_M_LINE_6)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_M_LINE_7 && hcount_in >= LEFT_M_LINE_7 && vcount_in>=TOP_M_LINE_7 && vcount_in<=BOT_M_LINE_7)
            rgb_nxt = 12'h0_0_f; 

      

        //Drawing G
        else if (hcount_in <= RIGHT_G_LINE_1 && hcount_in >= LEFT_G_LINE_1 && vcount_in>=TOP_G_LINE_1 && vcount_in<=BOT_G_LINE_1)
            rgb_nxt = 12'h0_0_f;
        else if (hcount_in <= RIGHT_G_LINE_2 && hcount_in >= LEFT_G_LINE_2 && vcount_in>=TOP_G_LINE_2 && vcount_in<=BOT_G_LINE_2)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_G_LINE_3 && hcount_in >= LEFT_G_LINE_3 && vcount_in>=TOP_G_LINE_3 && vcount_in<=BOT_G_LINE_3)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_G_LINE_4 && hcount_in >= LEFT_G_LINE_4 && vcount_in>=TOP_G_LINE_4 && vcount_in<=BOT_G_LINE_4)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_G_LINE_5 && hcount_in >= LEFT_G_LINE_5 && vcount_in>=TOP_G_LINE_5 && vcount_in<=BOT_G_LINE_5)
            rgb_nxt = 12'h0_0_f; 
        else if (hcount_in <= RIGHT_G_LINE_6 && hcount_in >= LEFT_G_LINE_6 && vcount_in>=TOP_G_LINE_6 && vcount_in<=BOT_G_LINE_6)
            rgb_nxt = 12'h0_0_f; 



        else                                    // The rest of active display pixels:
            rgb_nxt = 12'h8_8_8;                // - fill with gray.
    end
end

endmodule
