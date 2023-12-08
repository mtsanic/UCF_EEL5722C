`timescale 1ns / 1ps

module top_w_clk_tb;

reg clk;
wire [6:0] s_sgmt;
wire [3:0] an;

top_clk dut0(.clk(clk), .s_sgmt(s_sgmt), .an(an));

initial begin
    clk=0;
end

always begin
    #1 clk=~clk;
end


endmodule
