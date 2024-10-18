`timescale 1 ns / 1 ps

module draw_rect_ctl (
    input  logic clk,
    input  logic rst,
    input  logic mouse_left,
    input  logic mouse_right,
    input  logic [11:0] mouse_xpos,
    input  logic [11:0] mouse_ypos,
    output  logic [11:0] xpos,
    output  logic [11:0] ypos
);

logic mouse_left_prv;
logic mouse_left_nxt;
logic [11:0]ypos_nxt;
logic [19:0] counter;
logic [19:0] counter_nxt;
logic [5:0] a;
logic [5:0] a_nxt;
logic [15:0] a_counter;
logic [15:0] a_counter_nxt;

logic mouse_right_prv;
logic mouse_right_nxt;

always_ff @(posedge clk) begin
    if (rst) begin
        xpos <= '0;
        ypos <= '0;
        mouse_left_prv <= '0;
        mouse_left_nxt <= '0;
        mouse_right_prv <= '0;
        mouse_right_nxt <= '0;
        counter <= '0;
        a<= '0;
        a_counter <= '0;
    end else begin
        a <= a_nxt;
        a_counter <= a_counter_nxt;
        mouse_left_prv <= mouse_left;
        mouse_right_prv <= mouse_right;
        counter <= counter_nxt;
        xpos  <= mouse_xpos;
        ypos <= ypos_nxt;
        if(mouse_left_prv && !mouse_left)
            mouse_left_nxt <= '1;    
        if(mouse_right_prv && !mouse_right)
            mouse_right_nxt <= '1;
        if(mouse_right_nxt) begin      
            mouse_right_nxt <= '0;
            mouse_left_nxt <= '0;
            end       
    end
end

always_comb begin

    if (mouse_left_nxt && (ypos < 536)) begin
        if(counter >= 1000000)begin
            ypos_nxt = ypos + 1;
            counter_nxt = '0;
            if(a_counter >= 10) begin
                a_nxt = a + 1;
                a_counter_nxt = '0;
            end
            else begin
                a_counter_nxt = a_counter +1;
                a_nxt = a ;
            end
       end
       else begin
            ypos_nxt = ypos;
            counter_nxt = counter + a + 1;
            a_nxt = a;
            a_counter_nxt = a_counter;
       end
    end else if(mouse_left_nxt) begin
            ypos_nxt = 536;
            counter_nxt = '0;
            a_counter_nxt = '0;
            a_nxt = '0;
    end else begin
            ypos_nxt = mouse_ypos;
            counter_nxt = '0;
            a_counter_nxt = '0;
            a_nxt = '0;
    end
end
endmodule