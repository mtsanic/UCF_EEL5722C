`timescale 1ns / 1ps


module top(
    clk,        //|<i
    rst,        //|<i
    PS2Clk,     //|<i
    PS2Data,    //|<i
    an,         //|>o
    seg,        //|>o
    dp          //|>o
);

    input clk;
    input rst;
    input PS2Clk;
    input PS2Data;
    output [6:0] seg;
    output [3:0] an;
    output dp;

    reg [3:0] dec=0;
    wire [7:0] c_data;

    wire clk_20Hz, clk_1kHz;

    clk_gen_20Hz clk_gen_20Hz_0(.clk(clk), .rst(rst), .clk_20Hz(clk_20Hz));
    clk_gen_1kHz clk_gen_1kHz_0(.clk(clk), .rst(rst), .clk_1kHz(clk_1kHz));
    seven_segment_controller seven_segment_controller(.clk_1kHz(clk_1kHz), .rst(rst), .dec(dec), .seg(seg), .an(an));
    ps2_rx ps2_rx0(.clk(clk), .rst(rst), .PS2Clk(PS2Clk), .PS2Data(PS2Data), .c_data(c_data));

    assign an=4'b1110;
    assign dp=1'b1;

    always @(c_data) begin
        case (c_data)
            8'h45 : dec<=0;
            8'h16 : dec<=1;
            8'h1E : dec<=2;
            8'h26 : dec<=3;
            8'h25 : dec<=4;
            8'h2E : dec<=5;
            8'h36 : dec<=6;
            8'h3D : dec<=7;
            8'h3E : dec<=8;
            8'h46 : dec<=9;
            default: dec<=15;
        endcase
    end


endmodule
