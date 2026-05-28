module register_file (
    input clk,
    input reset,
    input RegWrite,
    input [4:0] rs1, rs2, rd,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] registers [31:0];  //32 registers each of 32bits wide
integer k;

assign read_data1 = registers[rs1];
assign read_data2 = registers[rs2];

always @(posedge clk) begin
    if (reset) begin
        for (k = 0; k < 32; k = k + 1) begin
            registers[k] <= 32'h0;
        end
    end 
    else begin
        if (RegWrite && rd != 5'd0) begin
            registers[rd] <= write_data;
        end
    end
end
endmodule 