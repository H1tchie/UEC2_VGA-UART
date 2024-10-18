`timescale 1 ns / 1 ps

module flipflop (
    input  logic clk,
    input  logic rst,
    input  logic [11:0] xpos_in,
    input  logic [11:0] ypos_in,
    output  logic [11:0] xpos_out,
    output  logic [11:0] ypos_out
);

logic [11:0] xpos_nxt;
logic [11:0] ypos_nxt;

always_ff @(posedge clk) begin
    if(rst) begin
        xpos_out <= 0;
        ypos_out <= 0;

    end
    else begin
        xpos_out <= xpos_nxt;
        ypos_out <= ypos_nxt;
    end
end

always_comb begin
    xpos_nxt = xpos_in;
    ypos_nxt = ypos_in;

end






endmodule