module top_uart (
    input  logic clk,
    input  logic reset,
    input  logic rx,
    // input  logic loopback_enable,
    output logic dp,
    input  logic db_ctr,
    output logic tx,
    output logic [3:0] an,
    output logic [6:0] seg
    // output logic tx_monitor,
    // output logic rx_monitor
);




wire [7:0] w_data;
wire [7:0] r_data;
wire btn_tick;
wire tx_full;
wire rx_empty;
wire tx_start;
wire [3:0] hex0;
wire [3:0] hex1;
wire [3:0] hex2;
wire [3:0] hex3;





uart u_uart(
    .clk,
    .reset,
    .rd_uart (!rx_empty),
    .wr_uart (tx_start),
    .rx,
    .w_data,
    .tx_full,
    .rx_empty,
    .tx,
    .r_data
);
debounce u_debounce(
    .clk,
    .reset,
    .sw (db_ctr),
    .db_level(),
    .db_tick(btn_tick)
    );
hex_chg u_hex_chg(
    .clk,
    .reset,
    .btn_tick,
    .hex0,
    .hex1,
    .hex2,
    .hex3,
    .tx_full,
    .r_data,
    .rx_empty,
    .tx_start,
    .w_data
);

disp_hex_mux u_disp_hex_mux(
    .clk,
    .reset,
    .hex0,
    .hex1,
    .hex2,
    .hex3,
    .dp_in(4'b1111),
    .an,
    .sseg ({dp, seg[0], seg[1], seg[2], seg[3], seg[4], seg[5], seg[6]})
);
/*adder u_adder(
    .clk,
    .reset,
    .w_data,
    .r_data
);
*/
endmodule