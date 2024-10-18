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

 module top_uart_basys3 (
     input  wire clk,
     input  wire RsRx,
     input  wire sw,
     input  wire btnC,
     input  wire btnU,
     output  wire dp,
     output wire RsTx,
     //output wire JA1,
     //output wire JA2,
     output wire [6:0] seg,
     output wire [3:0] an

 
     
 );
 
 
 /**
  * Local variables and signals
  */
 
 wire clk100MHz;
 wire clk50MHz;
 wire locked;
 //wire rx_monitor;
 //wire tx_monitor;
 wire tx;
 wire rx;
 wire loopback_enable;

 
 (* KEEP = "TRUE" *)
 (* ASYNC_REG = "TRUE" *)
 
 // For details on synthesis attributes used above, see AMD Xilinx UG 901:
 // https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Synthesis-Attributes
 
 
 /**
  * Signals assignments
  */
 
 //assign JA1 = rx_monitor;
 //assign JA2 = tx_monitor;
 assign loopback_enable = sw ;
 assign rx = RsRx;
 assign RsTx = tx;
 
 
 
 /**
  * FPGA submodules placement
  */
 
 /*
 IBUF clk_ibuf (
     .I(clk),
     .O(clk_in)
 );
 
 MMCME2_BASE #(
     .CLKIN1_PERIOD(10.000),
     .CLKFBOUT_MULT_F(10.000),
     .CLKOUT0_DIVIDE_F(25.000)
 ) clk_in_mmcme2 (
     .CLKIN1(clk_in),
     .CLKOUT0(clk_out),
     .CLKOUT0B(),
     .CLKOUT1(),
     .CLKOUT1B(),
     .CLKOUT2(),
     .CLKOUT2B(),
     .CLKOUT3(),
     .CLKOUT3B(),
     .CLKOUT4(),
     .CLKOUT5(),
     .CLKOUT6(),
     .CLKFBOUT(clk_fb),
     .CLKFBOUTB(),
     .CLKFBIN(clk_fb),
     .LOCKED(locked),
     .PWRDWN(1'b0),
     .RST(1'b0)
 );
 
 BUFH clk_out_bufh (
     .I(clk_out),
     .O(clk_ss)
 );
 
 always_ff @(posedge clk_ss)
     safe_start <= {safe_start[6:0],locked};
 
 BUFGCE #(
     .SIM_DEVICE("7SERIES")
 ) clk_out_bufgce (
     .I(clk_out),
     .CE(safe_start[7]),
     .O(pclk)
 );
 
 // Mirror pclk on a pin for use by the testbench;, clk_ss, clk_out;
 // not functionally required for this design to work.
 */
 (* CORE_GENERATION_INFO = "clk_wiz_0,clk_wiz_v6_0_9_0_0,{component_name=clk_wiz_0,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=MMCM,num_out_clk=2,clkin1_period=10.000,clkin2_period=10.000,use_power_down=false,use_reset=false,use_locked=true,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}" *)
 
   clk_wiz_0_clk_wiz inst
   (
   // Clock out ports  
   .clk_100MHz(clk100MHz),
   .clk_50MHz(clk50MHz),
   // Status and control signals               
   .locked(locked),
  // Clock in ports
   .clk(clk)
   );
 
 /**
  *  Project functional top module
  */
 
 top_uart u_top_uart (
     .clk(clk50MHz),
     .reset(btnC),
     .db_ctr (btnU),
     //.rx_monitor,
     //.tx_monitor,
     .rx,
     .tx,
     //.loopback_enable,
     .seg,
     .an,
     .dp

 );
 
 endmodule