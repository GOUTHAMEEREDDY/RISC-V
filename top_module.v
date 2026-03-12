module top_module (
    input clk,
    input reset
);

    wire [31:0] pc_out;
    wire [31:0] pc_next;
    wire [31:0] instruction;
    wire [31:0] imm_out;
    wire [31:0] read_data1, read_data2;
    wire [31:0] alu_operand_b;
    wire [31:0] alu_result;
    wire [31:0] mem_read_data;
    wire [31:0] reg_write_data;
    wire RegWrite, MemRead, MemWrite, MemtoReg, ALUSrc;
    wire [3:0] ALUControl;
   //instructions
    wire [6:0] opcode  = instruction[6:0];
    wire [4:0] rd      = instruction[11:7];
    wire [2:0] funct3  = instruction[14:12];
    wire [4:0] rs1     = instruction[19:15];
    wire [4:0] rs2     = instruction[24:20];
    wire [6:0] funct7  = instruction[31:25];

    // PC logic 
    assign pc_next = pc_out + 32'd4;

    // ALU operand 
    assign alu_operand_b = ALUSrc ? imm_out : read_data2;

    // Register write data 
    assign reg_write_data = MemtoReg ? mem_read_data : alu_result;

      pc Program_Counter (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_next),
        .pc_out(pc_out)
    );

    instruction_memory IM (
        .addr(pc_out),
        .instruction(instruction)
    );

    control_unit CU (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl)
        
    );

    register_file RF (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .rs1(rs1), .rs2(rs2), .rd(rd),
        .write_data(reg_write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    immediate_generator IG (
        .instruction(instruction),
        .imm_out(imm_out)
    );

    alu ALU (
        .a(read_data1),
        .b(alu_operand_b),
        .alu_control(ALUControl),
        .result(alu_result)
        
    );

    data_memory DM (
        .clk(clk),
        .reset(reset),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .addr(alu_result),           
        .write_data(read_data2),
        .read_data(mem_read_data)
    );

endmodule