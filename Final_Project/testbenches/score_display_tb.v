`timescale 1ns / 1ps

module score_display_tb;

    reg clk, rst, pause, enemy_hit;
    reg [9:0] x, y;
    wire score_on;

    score_display DUT0(clk, rst, pause, x, y, enemy_hit, score_on);



    initial begin
        rst=1;
        clk=0;
        pause=0;
        x=0;
        y=0;
        enemy_hit=0;
        #10
        rst=0;
        #5
        enemy_hit=1;
        #100
        enemy_hit=0;
        #200
        enemy_hit=1;
        #200
        enemy_hit=0;
        #20
        enemy_hit=1;
        #100
        $finish;
        
    end

    always begin
        #2 clk=~clk;
    end
    always begin
        #1 
        x=x+1;
        y=y+1;
    end


endmodule