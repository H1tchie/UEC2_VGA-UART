module hex_chg (
    input  logic clk,
    input  logic reset,
    input  logic rx_empty,
    input  logic tx_full,
    output logic tx_start,
    input  logic btn_tick,
    input  logic [7:0] r_data,
    output logic [7:0] w_data,
    output logic [3:0] hex0,
    output logic [3:0] hex1,
    output logic [3:0] hex2,
    output logic [3:0] hex3
);
logic [7:0] last_byte;
logic [7:0] prev_byte;

always_ff @(posedge clk) begin
    if(reset) begin
    last_byte <= '0;
    prev_byte <= '0;
    tx_start <='0;
    end else if (!rx_empty) begin
    prev_byte <= last_byte;
    last_byte <= r_data;
    tx_start <= '0;
    end else if (btn_tick && !tx_full) begin
    prev_byte <= prev_byte;
    last_byte <= last_byte;
    tx_start <= 1;
    end else begin
    prev_byte <= prev_byte;
    last_byte <= last_byte;
    tx_start <= '0;
    end
end

assign hex0 = last_byte[3:0];
assign hex1 = last_byte[7:4];
assign hex2 = prev_byte[3:0];
assign hex3 = prev_byte[7:4];
assign w_data = last_byte;

endmodule
