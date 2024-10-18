/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// Parameters for VGA Display 800 x 600 @ 60fps using a 40 MHz clock;
localparam HOR_PIXELS = 800;
localparam VER_PIXELS = 600;

// Add VGA timing parameters here and refer to them in other modules.
localparam HOR_MAX = 1056;
localparam VER_MAX = 628;


localparam HOR_SYNCH_START = 840;
localparam HOR_SYNCH_STOP = 968;

localparam VER_SYNCH_START = 601;
localparam VER_SYNCH_STOP = 605;


localparam VER_BLANK_START = 600;
localparam HOR_BLANK_START = 800;

//DRAWING M
localparam RIGHT_M_LINE_1 = 133;
localparam LEFT_M_LINE_1 = 127;
localparam TOP_M_LINE_1 = 88;
localparam BOT_M_LINE_1 = 200; 

localparam RIGHT_M_LINE_2 = 188;
localparam LEFT_M_LINE_2 = 127;
localparam TOP_M_LINE_2 = 88;
localparam BOT_M_LINE_2 = 94; 

localparam RIGHT_M_LINE_3 = 188;
localparam LEFT_M_LINE_3 = 182;
localparam TOP_M_LINE_3 = 88;
localparam BOT_M_LINE_3 = 140; 

localparam RIGHT_M_LINE_4 = 234;
localparam LEFT_M_LINE_4 = 182;
localparam TOP_M_LINE_4 = 134;
localparam BOT_M_LINE_4 = 140; 

localparam RIGHT_M_LINE_5 = 234;
localparam LEFT_M_LINE_5 = 228;
localparam TOP_M_LINE_5 = 88;
localparam BOT_M_LINE_5 = 140; 

localparam RIGHT_M_LINE_6 = 280;
localparam LEFT_M_LINE_6 = 228;
localparam TOP_M_LINE_6 = 88;
localparam BOT_M_LINE_6 = 94; 

localparam RIGHT_M_LINE_7 = 280;
localparam LEFT_M_LINE_7 = 274;
localparam TOP_M_LINE_7 = 88;
localparam BOT_M_LINE_7 = 200; 

//DRAWING G
localparam RIGHT_G_LINE_1 = 407;
localparam LEFT_G_LINE_1 = 401;
localparam TOP_G_LINE_1 = 88;
localparam BOT_G_LINE_1 = 119; 

localparam RIGHT_G_LINE_2 = 407;
localparam LEFT_G_LINE_2 = 324;
localparam TOP_G_LINE_2 = 88;
localparam BOT_G_LINE_2 = 94; 

localparam RIGHT_G_LINE_3 = 330;
localparam LEFT_G_LINE_3 = 324;
localparam TOP_G_LINE_3 = 88;
localparam BOT_G_LINE_3 = 200; 

localparam RIGHT_G_LINE_4 = 407;
localparam LEFT_G_LINE_4 = 324;
localparam TOP_G_LINE_4 = 194;
localparam BOT_G_LINE_4 = 200; 

localparam RIGHT_G_LINE_5 = 407;
localparam LEFT_G_LINE_5 = 401;
localparam TOP_G_LINE_5 = 148;
localparam BOT_G_LINE_5 = 200; 

localparam RIGHT_G_LINE_6 = 407;
localparam LEFT_G_LINE_6 = 362;
localparam TOP_G_LINE_6 = 148;
localparam BOT_G_LINE_6 = 154; 

//RECTANGLE

localparam REC_X = 50;
localparam REC_Y = 80;
localparam REC_W = 48;
localparam REC_H = 64;
localparam REC_C = 12'h0_f_0;


endpackage
