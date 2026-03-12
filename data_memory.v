module data_memory (
    input clk,
    input reset,
    input MemRead,
    input MemWrite,
    input  [31:0] addr,
    input  [31:0] write_data,
    output [31:0] read_data
);

    reg [31:0] memory [0:255];  // 1 KB (256 × 4 bytes)
    integer k;

    // Word-aligned access
    assign read_data = MemRead ? memory[addr[9:2]] : 32'h0;

    always @(posedge clk) begin
        if (reset) begin
            for (k = 0; k < 256; k = k + 1)
                memory[k] <= 32'h0;
        end
        else if (MemWrite) begin
            memory[addr[9:2]] <= write_data;
        end
    end

endmodule
