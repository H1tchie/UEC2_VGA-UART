module hexconverter(
   input wire clk,
   input wire rst,
   input logic [7:0] data,
   input wire rx_empty,
   output logic uart,
   output logic [3:0] seg0, seg1, seg2, seg3
);

logic uart_nxt;
logic [3:0] seg0_nxt;
logic [3:0] seg1_nxt;
logic [3:0] seg2_nxt;
logic [3:0] seg3_nxt;

always_ff @(posedge clk, posedge rst) begin
   if(rst) begin
       uart <= 0;
       seg0 <= 0;
       seg1 <= 0;
       seg2 <= 0;
       seg3 <= 0;
   end
   else begin
       uart <= uart_nxt;
       seg0 <= seg0_nxt;
       seg1 <= seg1_nxt;
       seg2 <= seg2_nxt;
       seg3 <= seg3_nxt;
   end
end

always_comb begin
   if (uart) begin
       uart_nxt = 0;
       seg0_nxt = seg0;
       seg1_nxt = seg1;
       seg2_nxt = seg2;
       seg3_nxt = seg3;        
   end
   else begin
       if(rx_empty) begin
           uart_nxt = 0;
           seg0_nxt = seg0;
           seg1_nxt = seg1;
           seg2_nxt = seg2;
           seg3_nxt = seg3;
       end
       else begin
           uart_nxt = 1;
           seg0_nxt = data[3:0];
           seg1_nxt = data[7:4];
           seg2_nxt = seg0;
           seg3_nxt = seg1;
       end
   end
end
endmodule