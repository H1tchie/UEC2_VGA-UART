/**
 *  Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Testbench for vga_timing module.
 */

`timescale 1 ns / 1 ps

module vga_timing_tb;

import vga_pkg::*;


/**
 *  Local parameters
 */

localparam CLK_PERIOD = 25;     // 40 MHz


/**
 * Local variables and signals
 */

logic clk;
logic rst;

vga_if vga_out;


/**
 * Clock generation
 */

initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
end


/**
 * Reset generation
 */

initial begin
                       rst = 1'b0;
    #(1.25*CLK_PERIOD) rst = 1'b1;
                       rst = 1'b1;
    #(2.00*CLK_PERIOD) rst = 1'b0;
    zero();
end


/**
 * Dut placement
 */

vga_timing dut(
    .clk,
    .rst,
    .vga_out 
);

/**
 * Tasks and functions
 */

 // Here you can declare tasks with immediate assertions (assert).
 
 task zero;
 
assert (vga_out.hcount == 0 && vga_out.vcount == 0)// $display ("We are at the top left corner of screen");
     else $error("reset nie dziala");
 

endtask
/**
 */

// Here you can declare concurrent assertions (assert property).

 // UWAGA 2 PIERWSZE ERRORY Z KAZDEJ ASSERCJI WYNIKAJA Z STANU NIEUSTALONEGO NA POCZATKU SYMULACJI
// NIEBRAC ICH POD UWAGE PRZY DEBUGOWANIU
 assert property (@(posedge clk)vga_out.hcount<=HOR_MAX || vga_out.hcount === 'x )// $display ("hcoount jest w zakresie");
    else $error("vga_out.hcount poza zakresem");
assert property (@(posedge clk)vga_out.vcount<=VER_MAX ||vga_out.vcount === 'x)// $display ("vga_out.vcount jest w zakresie");
    else $error("vga_out.vcount poza zakresem");
assert property (@(posedge clk)((vga_out.vcount > VER_SYNCH_START-1) && (vga_out.vcount < VER_SYNCH_STOP) & vga_out.vsync == 1) || vga_out.vcount === 'x|| ((vga_out.vcount <= VER_SYNCH_START-1) || (vga_out.vcount >= VER_SYNCH_STOP) & vga_out.vsync == 0) )
    else $error("synchronizacja wertykalna nie dziala");
assert property (@(posedge clk)((vga_out.hcount > HOR_SYNCH_START-1) && (vga_out.hcount < HOR_SYNCH_STOP) & vga_out.hsync == 1) || vga_out.hcount === 'x|| ((vga_out.hcount <= HOR_SYNCH_START-1) || (vga_out.hcount >= HOR_SYNCH_STOP) & vga_out.hsync == 0) )
    else $error("synchronizacja horyzontalna nie dziala");
assert property (@(posedge clk)(vga_out.vcount>= VER_BLANK_START && vga_out.vblnk == 1)|| vga_out.vcount === 'x||(vga_out.vcount<VER_BLANK_START && vga_out.vblnk == 0))
    else $error("blanking wertykalny nie dziala");
assert property (@(posedge clk)(vga_out.hcount>= HOR_BLANK_START && vga_out.hblnk == 1)||vga_out.hcount === 'x||(vga_out.hcount<HOR_BLANK_START && vga_out.hblnk == 0))
    else $error("blanking horyzontalny nie dziala");


/**
 * Main test
 */

initial begin
    @(posedge rst);
    @(negedge rst);

    wait (vga_out.vsync == 1'b0);
    @(negedge vga_out.vsync)
    @(negedge vga_out.vsync)

    $finish;
end

endmodule
