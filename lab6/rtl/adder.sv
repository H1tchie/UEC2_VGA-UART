module adder (
    input  logic clk,
    input  logic reset,
    input  logic [7:0] r_data,
    output logic [7:0] w_data
);
logic [7:0] w_nxt;

always_ff @(posedge clk) begin
    if(reset)
    w_data <= '0;
    else
    w_data <= w_nxt;
end
always_comb @(posedge clk) begin
    w_nxt = r_data + 1;
end
endmodule

