`timescale 1ns / 1ps


module btn_cntl_tb;

reg clk_20Hz;
reg rst;
reg btnU;

wire [2:0] leds;

led_cntl DUT0(.clk_20Hz(clk_20Hz), .rst(rst), .btnU(btnU),  .leds(leds));

initial begin
    clk_20Hz=0;
    rst=1;
    btnU=0;
    #5
    rst=0;
    #5
    btnU=1;
    #20
    $finish;
end

always begin
    #1 clk_20Hz=~clk_20Hz;
end


endmodule
