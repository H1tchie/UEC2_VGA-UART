module top_micro(
    input wire clk100MHz,
    input wire rst,
    input  wire rx,
    input  wire btnU,
    input  wire btnL,
    input wire [5:0] sw,
    output logic [3:0] an,
    output logic [6:0] seg,
    output logic dp,
    output logic tx
);

logic [3:0] hex0, hex1, hex2, hex3;
logic [15:0] data, monInstr, monPC, monRFData, data_micro;
logic level_U, tick_L, rx_empty, uart, we;
logic [7:0] data_rd, wa;

micro u_micro(
    .clk(clk100MHz),
    .extCtl(level_U),
    .PCenable(tick_L),
    .reset(rst),
    .monInstr,
    .monPC,
    .monRFData,
    .monRFSrc(sw[3:0]),
    .iram_din(data_micro),
    .iram_wa(wa),
    .iram_wen(we)
);



debounce u_debounce_L (
    .clk(clk100MHz),
    .db_level(),
    .db_tick(tick_L),
    .reset(rst),
    .sw(btnL)
);

debounce u_debounce_U (
    .clk(clk100MHz),
    .db_level(level_U),
    .db_tick(),
    .reset(rst),
    .sw(btnU)
);
output_sig u_output_sig(
    .clk(clk100MHz),
    .rst,
    .monInstr,
    .monPC,
    .monRFData,
    .sig_data(data),
    .sw(sw[5:4])
);

disp_hex_mux u_disp_hex_mux(
    .an,
    .clk(clk100MHz),
    .dp_in(4'b1111),
    .reset(rst),
    .hex0(data[3:0]),
    .hex1(data[7:4]),
    .hex2(data[11:8]),
    .hex3(data[15:12]),
    .sseg({dp, seg[0], seg[1],seg[2],seg[3],seg[4],seg[5],seg[6]})
);

uart u_uart(
    .clk(clk100MHz),
    .reset(rst),
    .rx,
    .tx,
    .r_data(data_rd),
    .rd_uart(uart),
    .rx_empty,
    .tx_full(),
    .w_data(),
    .wr_uart()
);

control u_control(
    .clk(clk100MHz),
    .hex0,
    .hex1,
    .hex2,
    .hex3,
    .data(data_micro),
    .uart,
    .rst,
    .we,
    .wa
);

hexconverter u_hexconverter(
    .clk(clk100MHz),
    .rst,
    .data(data_rd),
    .seg0(hex0),
    .seg1(hex1),
    .seg2(hex2),
    .seg3(hex3),
    .uart,
    .rx_empty
);

endmodule