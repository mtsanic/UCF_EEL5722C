`timescale 1ns / 1ps

module top_tb;

   reg clk, rst;                                    
   reg PB_ENTER, PB_UP, PB_DOWN, PB_LEFT, PB_RIGHT;  
   reg pause;                                              
   wire hsync, vsync;                                
   wire [11:0] rgb;       

    top_module DUT0(clk, rst, PB_ENTER, PB_UP, PB_DOWN, PB_LEFT, PB_RIGHT, pause, hsync, vsync, rgb);



    initial begin
        rst=1;
        clk=0;
        pause=0;
        PB_ENTER=1;
        PB_UP=0;
        PB_DOWN=0;
        PB_LEFT=0;
        PB_RIGHT=0;
        #10
        rst=0;
        #5
        #100
        #200
        #200
        #20
        #100
        $finish;
        
    end

    always begin
        #1 clk=~clk;
    end


endmodule
