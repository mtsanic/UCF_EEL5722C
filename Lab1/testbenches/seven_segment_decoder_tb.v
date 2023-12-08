`timescale 1ns / 1ps
module seven_segment_decoder_tb;

reg [3:0]dec;
wire [6:0] seven_segment;

seven_segment_decoder dut0(.dec(dec), .seven_segment(seven_segment));

initial begin
    dec=0;
    #10
    dec=1;
    #10
    dec=2;
    #10
    dec=3;
    #10
    dec=4;
    #10
    dec=5;
    #10
    dec=6;
    #10
    dec=7;
    #10
    dec=8;
    #10
    dec=9;
    $finish;
end


endmodule
