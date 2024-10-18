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
 * Top level synthesizable module including the project top and all the FPGA-referred modules.
 */

 `timescale 1 ns / 1 ps

 module top_vga_basys3 (
     input  wire clk,
     input  wire btnC,
     input  wire btnU,
     input  wire btnL,
     input wire [5:0] sw,
     input  wire RsRx,
     output wire [3:0] an,
     output wire [6:0] seg,
     output wire dp,
     output wire RsTx
 );
 
 
 /**
  * Local variables and signals
  */
 
 wire clk100MHz;
 
 wire locked;
 wire pclk;
 wire pclk_mirror;
 
 (* KEEP = "TRUE" *)
 (* ASYNC_REG = "TRUE" *)
 logic [7:0] safe_start = 0;
 // For details on synthesis attributes used above, see AMD Xilinx UG 901:
 // https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes
 
 
 /**
  * Signals assignments
  */
 
 assign JA1 = pclk_mirror;
 
 
 /**
  * FPGA submodules placement
  */
 
 
  clk_wiz_0_clk_wiz CLK (
     .clk (clk),
     .clk100MHz (clk100MHz),
     .clk40MHz (pclk),
     .locked
 
  );
  
 // Mirror pclk on a pin for use by the testbench;
 // not functionally required for this design to work.
 ODDR pclk_oddr (
     .Q(pclk_mirror),
     .C(pclk),
     .CE(1'b1),
     .D1(1'b1),
     .D2(1'b0),
     .R(1'b0),
     .S(1'b0)
 );
 
 /**
  *  Project functional top module
  */
 
 top_micro u_top_micro (
     .clk100MHz (clk100MHz),
     .rst(btnC),
     .btnU,
     .btnL,
     .sw,
     .an,
     .dp,
     .seg,
     .rx(RsRx),
     .tx(RsTx)
 );
 
 endmodule
 