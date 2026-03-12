module control_unit (
    input  [6:0] opcode,
    input  [2:0] funct3,
    input  [6:0] funct7,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg MemtoReg,
    output reg ALUSrc,
    output reg [3:0] ALUControl
);

always @(*) begin
    RegWrite   = 1'b0;
    MemRead    = 1'b0;
    MemWrite   = 1'b0;
    MemtoReg   = 1'b0;
    ALUSrc     = 1'b0;
    ALUControl = 4'b0000;           

    case (opcode)
        7'b0110011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b0;               

            if (funct7 == 7'b0000000) begin
                case (funct3)
                    3'b000: ALUControl = 4'b0000; // ADD
                    3'b111: ALUControl = 4'b0010; // AND
                    3'b110: ALUControl = 4'b0011; // OR
                    3'b100: ALUControl = 4'b0100; // XOR
                    default: RegWrite = 1'b0;    
                endcase
            end
            else if (funct7 == 7'b0100000 && funct3 == 3'b000) begin
                ALUControl = 4'b0001; // SUB
            end
            else begin
                RegWrite = 1'b0;         
            end
        end

        
        7'b0010011: begin
            if (funct3 == 3'b000) begin       // only ADDI
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000;         // ADD
            end
           
        end

        // Load(LW)
        7'b0000011: begin
            if (funct3 == 3'b010) begin       
                RegWrite   = 1'b1;
                MemRead    = 1'b1;
                MemtoReg   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000;
            end 
        end
        7'b0100011: begin
            if (funct3 == 3'b010) begin     
                MemWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000;
            end   
        end
        default: ;
    endcase
end
endmodule
