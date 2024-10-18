module output_sig(
    input wire clk,
    input wire rst,
    input wire [1:0] sw,
    input wire [15:0] monInstr,
    input wire [15:0] monPC,
    input wire [15:0] monRFData,
    output logic [15:0] sig_data
);

logic [15:0] sig_data_nxt;

always_ff @(posedge clk) begin
    if(rst)
        sig_data <= '0;
    else
        sig_data <= sig_data_nxt;
end

always_comb begin
    case(sw) 
        2'b01: sig_data_nxt = monInstr;
        2'b10: sig_data_nxt = monPC;
        2'b11: sig_data_nxt = monRFData;
        default: sig_data_nxt = sig_data;
    endcase
end


endmodule