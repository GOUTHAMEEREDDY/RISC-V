module instruction_memory (
    input  [31:0] addr,
    output [31:0] instruction
);

    reg [31:0] memory [0:63];  

    assign instruction = (addr[7:2] < 64) ? memory[addr[7:2]] : 32'b0;   //as the lowest 2 bits of address are always 00 we ignore addr[1:0]

    initial begin
      
    // Immediate operations
    memory[0] = 32'h00500093;   // addi x1,x0,5
    memory[1] = 32'h00A00113;   // addi x2,x0,10

    // R-type operations
    memory[2] = 32'h002081B3;   // add x3, x1, x2
    memory[3] = 32'h40208233;   // sub x4, x1, x2
    memory[4] = 32'h0020F2B3;   // and x5, x1, x2
    memory[5] = 32'h0020E333;   // or  x6, x1, x2
    memory[6] = 32'h0020C3B3;   // xor x7, x1, x2

    // Memory operations
    memory[7] = 32'h00302023;   // sw x3, 0(x0)
    memory[8] = 32'h00002403;   // lw x8, 0(x0)

end
   

endmodule
