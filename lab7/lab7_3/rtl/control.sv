`timescale 1 ns / 1 ps

module control (
    input  wire clk,
    input  wire rst,
    input  wire uart, 
    input  wire [3:0] hex0, hex1, hex2, hex3,
    output logic we,
    output logic [7:0] wa,
    output logic [15:0] data 
);

logic we_nxt;
logic [1:0] number, number_nxt;
logic [7:0] wa_nxt; 
logic [15:0] data_nxt;

always_ff @(posedge clk) begin
    if(rst) begin
        we    <= 0;
        number <= 0;
        wa     <= 0;
        data   <= 0;
    end
    else begin
        we    <= we_nxt;
        number <= number_nxt;
        wa     <= wa_nxt;
        data   <= data_nxt;
    end
end

always_comb begin
    if(uart) begin
        if(number == 1) begin
            data_nxt = {hex3, hex2, hex1, hex0};
            we_nxt = 1;
            wa_nxt = wa + 1; 
            number_nxt = 0;
        end
        else begin
            number_nxt = number + 1;
            wa_nxt = wa; 
            data_nxt = data;
            we_nxt = 0;
        end
    end
    else begin
        data_nxt = data;
        number_nxt = number;
        we_nxt = 0;
        wa_nxt = wa;
    end
end

endmodule
