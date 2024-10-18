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

    vga_if.out vga_out,
    vga_if.in vga_in 
);

import vga_pkg::*;


/**
 * Local variables and signals
 */

 vga_if vga_nxt();


/**
 * Internal logic
 */

always_ff @(posedge clk) begin : bg_ff_blk
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

always_comb begin : bg_comb_blk
    if (vga_in.vblnk || vga_in.hblnk) begin             // Blanking region:
        vga_nxt.rgb = 12'h0_0_0;                    // - make it it black.
    end else begin                              // Active region:
        if (vga_in.vcount == 0)                     // - top edge:
            vga_nxt.rgb = 12'hf_f_0;                // - - make a yellow line.
        else if (vga_in.vcount == VER_PIXELS - 1)   // - bottom edge:
            vga_nxt.rgb = 12'hf_0_0;                // - - make a red line.
        else if (vga_in.hcount == 0)                // - left edge:
            vga_nxt.rgb = 12'h0_f_0;                // - - make a green line.
        else if (vga_in.hcount == HOR_PIXELS - 1)   // - right edge:
            vga_nxt.rgb = 12'h0_0_f;                // - - make a blue line.

        // Add your code here.

        //Drawing M
        else if (vga_in.hcount <= RIGHT_M_LINE_1 && vga_in.hcount >= LEFT_M_LINE_1 && vga_in.vcount>=TOP_M_LINE_1 && vga_in.vcount<=BOT_M_LINE_1)
            vga_nxt.rgb = 12'h0_0_f;
        else if (vga_in.hcount <= RIGHT_M_LINE_2 && vga_in.hcount >= LEFT_M_LINE_2 && vga_in.vcount>=TOP_M_LINE_2 && vga_in.vcount<=BOT_M_LINE_2)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_M_LINE_3 && vga_in.hcount >= LEFT_M_LINE_3 && vga_in.vcount>=TOP_M_LINE_3 && vga_in.vcount<=BOT_M_LINE_3)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_M_LINE_4 && vga_in.hcount >= LEFT_M_LINE_4 && vga_in.vcount>=TOP_M_LINE_4 && vga_in.vcount<=BOT_M_LINE_4)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_M_LINE_5 && vga_in.hcount >= LEFT_M_LINE_5 && vga_in.vcount>=TOP_M_LINE_5 && vga_in.vcount<=BOT_M_LINE_5)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_M_LINE_6 && vga_in.hcount >= LEFT_M_LINE_6 && vga_in.vcount>=TOP_M_LINE_6 && vga_in.vcount<=BOT_M_LINE_6)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_M_LINE_7 && vga_in.hcount >= LEFT_M_LINE_7 && vga_in.vcount>=TOP_M_LINE_7 && vga_in.vcount<=BOT_M_LINE_7)
            vga_nxt.rgb = 12'h0_0_f; 

      

        //Drawing G
        else if (vga_in.hcount <= RIGHT_G_LINE_1 && vga_in.hcount >= LEFT_G_LINE_1 && vga_in.vcount>=TOP_G_LINE_1 && vga_in.vcount<=BOT_G_LINE_1)
            vga_nxt.rgb = 12'h0_0_f;
        else if (vga_in.hcount <= RIGHT_G_LINE_2 && vga_in.hcount >= LEFT_G_LINE_2 && vga_in.vcount>=TOP_G_LINE_2 && vga_in.vcount<=BOT_G_LINE_2)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_G_LINE_3 && vga_in.hcount >= LEFT_G_LINE_3 && vga_in.vcount>=TOP_G_LINE_3 && vga_in.vcount<=BOT_G_LINE_3)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_G_LINE_4 && vga_in.hcount >= LEFT_G_LINE_4 && vga_in.vcount>=TOP_G_LINE_4 && vga_in.vcount<=BOT_G_LINE_4)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_G_LINE_5 && vga_in.hcount >= LEFT_G_LINE_5 && vga_in.vcount>=TOP_G_LINE_5 && vga_in.vcount<=BOT_G_LINE_5)
            vga_nxt.rgb = 12'h0_0_f; 
        else if (vga_in.hcount <= RIGHT_G_LINE_6 && vga_in.hcount >= LEFT_G_LINE_6 && vga_in.vcount>=TOP_G_LINE_6 && vga_in.vcount<=BOT_G_LINE_6)
            vga_nxt.rgb = 12'h0_0_f; 



        else                                    // The rest of active display pixels:
            vga_nxt.rgb = 12'h8_8_8;                // - fill with gray.
    end
end

endmodule
