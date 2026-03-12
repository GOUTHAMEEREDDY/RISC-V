
module alu (
    input [31:0] a, //value comes register rs1
    input [31:0] b, //value comes either from rs2(read_data2) or immediate
    input [3:0] alu_control,
    output reg [31:0] result
);

always @(*) begin
    case (alu_control)
        4'b0000: result = a + b;  // ADD
        4'b0001: result = a - b;  // SUB
        4'b0010: result = a & b;  // AND
        4'b0011: result = a | b;  // OR
        4'b0100: result = a ^ b;  // XOR
        default: result = 32'h00000000;
    endcase
end

endmodule
