`timescale 1ns /1ps


module clock_gen_tb;

reg clk;
wire clk_10Hz, clk_500Hz;

clk_gen_10HZ dut0(.clk(clk), .clk_10Hz(clk_10Hz));
clk_gen_500Hz dut1(.clk(clk), .clk_500Hz(clk_500Hz));

initial begin
    clk=0;
end

always begin
    #1 clk=~clk;
end


endmodule
