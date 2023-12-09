`timescale 1ns / 1ps

module binary2bcd_tb;

    reg clk, rst, start;
    reg [13:0] in;
    wire [3:0] bcd3, bcd2, bcd1, bcd0, count;
    wire [1:0] state;

    binary2bcd DUT0(clk, rst, start, in, bcd3, bcd2, bcd1, bcd0, count, state);



    initial begin
        rst=1;
        clk=0;
        start=0;
        in=0;
        #10
        rst=0;
        #10
        in=9999;
        start=1;
        #10
        start=0;
        #256
        in=7645;
        #256
        in=10;
        #2
        start=1;
        #2
        start=0;
        #256
        $finish;
        
    end

    always begin
        #1 clk=~clk;
    end

endmodule
