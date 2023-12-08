`timescale 1ns / 1ps

module top_w_btn_tb;

reg clk;
reg [1:0] btn;
wire [6:0] s_sgmt;
wire [3:0] an;


top dut0(.clk(clk), .btn(btn), .s_sgmt(s_sgmt), .an(an));

initial begin
    clk=0;
    btn=1;
    #12000000
    btn=2;
    #12000000
    btn=3;
    #12000000
    btn=0;
    #20000000
    $finish;
end

always begin
    #1 clk=~clk;
end


endmodule
