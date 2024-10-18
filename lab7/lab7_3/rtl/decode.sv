module decode (
    input  wire [3:0] OPcode,
    input  wire       en,
    
    /* [0] - update Carry and Overflow flags; 
     * [1] - update Neg and  Zero flags;
     *  ADD, SUB - update all flags; 
     * AND, OR - update only Neg and Zero
     *  */
    output logic  [1:0] UpdateFlags,
     
    output logic  [1:0] ALUControl,
    output logic  [1:0] RegFileControl
);
localparam ADD = 3'b000;
localparam SUB = 3'b001;
localparam AND = 3'b010;
localparam OR = 3'b011;
localparam NOP = 3'b111;
localparam LDA = 3'b100;
localparam LDB = 3'b101;
//------------------------------------------------------------------------------
// put your code here
always_comb begin
    case(OPcode[2:0])
        ADD: begin
            ALUControl = 2'b00;
            UpdateFlags = 2'b11;
        end
        SUB: begin 
            ALUControl = 2'b01;
            UpdateFlags = 2'b11;
        end
        AND: begin 
            ALUControl = 2'b10;
            UpdateFlags = 2'b10;
        end
        OR:  begin 
            ALUControl = 2'b11;
            UpdateFlags = 2'b10;
        end
        default: begin 
            ALUControl = 2'b00;
            UpdateFlags = 2'b00;
        end
    endcase   
end
//------------------------------------------------------------------------------
always_comb begin
    if(!en)
        RegFileControl = 2'b00;
    else
        if(OPcode[3]) // branch
            RegFileControl = 2'b00;
        else begin    // execute
            case(OPcode[2:0])
                ADD, SUB, AND, OR: RegFileControl = 2'b01;
                LDA: RegFileControl               = 2'b11;
                LDB: RegFileControl               = 2'b10;
                NOP: RegFileControl               = 2'b00;
                default: RegFileControl           = 2'b00;
            endcase
        end
end

endmodule

