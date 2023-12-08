`timescale 1ns / 1ps

module seven_segment_controller_tb;

reg clk_500Hz;
reg [3:0] dec0;
reg [3:0] dec1;
wire [6:0] s_sgmt;
wire [3:0] an;

seven_segment_controller dut0( .clk_500Hz(clk_500Hz),  .dec0(dec0), .dec1(dec1), .s_sgmt(s_sgmt), .an(an));

initial begin
    clk_500Hz<=0;
    dec0<=5;
    dec1<=9;
    #5
    dec0<=4;
    dec1<=2;
end

always begin
    #1 clk_500Hz=~clk_500Hz;
end


endmodule
