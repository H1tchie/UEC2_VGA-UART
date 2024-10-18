/**
 * San Jose State University
 * EE178 Lab #4
 * Author: prof. Eric Crabilla
 *
 * Modified by:
 * 2023  AGH University of Science and Technology
 * MTM UEC2
 * Piotr Kaczmarczyk
 *
 * Description:
 * The project top module.
 */

`timescale 1 ns / 1 ps

module top_vga (
    input  logic clk,
    input  logic rst,
    output logic vs,
    output logic hs,
    output logic [3:0] r,
    output logic [3:0] g,
    output logic [3:0] b,
    inout  logic ps2_clk,
    inout  logic ps2_data,
    input  logic clk100
);


/**
 * Local variables and signals
 */

// VGA signals from timing
 vga_if vga_tim();

// VGA signals from background
 vga_if vga_bg();

// VGA signals from background
 vga_if vga_rect();

 // VGA signals from mouse dsplay
 vga_if vga_mouse();


/**
 * Signals assignments
 */

assign vs = vga_mouse.vsync;
assign hs = vga_mouse.hsync;
assign {r,g,b} = vga_mouse.rgb;


/**
 * Submodules instances
 */

vga_timing u_vga_timing (
    .clk,
    .rst,
    .vga_out (vga_tim)

);

draw_bg u_draw_bg (
    .clk,
    .rst,
    .vga_in  (vga_tim),
    .vga_out (vga_bg)
  
);

wire [11:0] xwire;
wire [11:0] ywire;

wire [11:0] xwire_mouse;
wire [11:0] ywire_mouse;

draw_rect u_draw_rect (
    .clk,
    .rst,
    .xpos (xwire),
    .ypos (ywire),

    .vga_in  (vga_bg),
    .vga_out (vga_rect)
);

draw_mouse u_draw_mouse (
    .clk,
    .rst,
    .xpos (xwire),
    .ypos (ywire),

    .vga_in  (vga_rect),
    .vga_out (vga_mouse)
);


MouseCtl u_MauseCtl (
    .clk(clk100),
    .rst,
    .xpos (xwire_mouse),
    .ypos (ywire_mouse),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .zpos        (),
    .left        (),
    .middle      (),
    .right       (),
    .new_event   (),
    .value       ('0),
    .setx        ('0),
    .sety        ('0),
    .setmax_x    ('0),
    .setmax_y    ('0)
);

flipflop u_flipflop (
    .clk,
    .rst,
    .xpos_in (xwire_mouse),
    .ypos_in (ywire_mouse),
    .xpos_out (xwire),
    .ypos_out (ywire)
);




endmodule
