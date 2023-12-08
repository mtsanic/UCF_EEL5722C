`timescale 1ns / 1ps

module LFSR_16_tb;

    reg clk, rst, w_en;
    reg [15:0] w_in;
    wire [15:0] out;

    LFSR_16 DUT0(clk, rst, w_en, w_in, out);


    initial begin
        rst=1;
        clk=0;
        w_en=0;
        w_in=16'h0000;
        #5
        rst=0;
        #5
        w_en=1;
        #5
        $finish;
    end

    always begin
        #1 clk=~clk;
    end

endmodule
