`timescale 1 ns / 1 ps

module uart_ctr (
    input  logic clk,
    input  logic rst,
    input  logic rx,
    input  logic loopback_enable,
    output logic tx,
    output logic tx_monitor,
    output logic rx_monitor

);
logic rx_nxt;
logic tx_nxt;

assign tx = tx_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        rx_monitor <= '0;
        tx_monitor <= '0;
    end else begin
        rx_monitor <= rx_nxt;
        tx_monitor <= tx_nxt;
    end
end

always_comb @(posedge clk) begin
    rx_nxt = rx;
    if (loopback_enable == 1)
        tx_nxt = rx;
    else
        tx_nxt = '0;
end


endmodule
