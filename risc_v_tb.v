`timescale 1ps/1ps
module risc_v_tb;
reg clk;
reg reset;
top_module uut (
    .clk(clk),
    .reset(reset)
);
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
    #100;
    $finish;
end
endmodule
