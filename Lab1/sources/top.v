`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Design with Button Control
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    clk,        //|<i
    btn,        //|<i
    s_sgmt,     //|>o
    an          //|>o
);

input clk;
input [1:0] btn;
output [6:0] s_sgmt;
output [3:0] an;

wire clk_10Hz, clk_500Hz;
wire [3:0] dec0;
wire [3:0] dec1;

clk_gen_10HZ clk_gen_10Hz_0(.clk(clk), .clk_10Hz(clk_10Hz));
clk_gen_500Hz clk_gen_500Hz_0(.clk(clk), .clk_500Hz(clk_500Hz));

state_machine_w_btn state_machine_w_btn0(.clk_10Hz(clk_10Hz), .btn(btn), .dec0(dec0), .dec1(dec1));
seven_segment_controller seven_segment_controller0(.clk_500Hz(clk_500Hz), .dec0(dec0), .dec1(dec1), .s_sgmt(s_sgmt), .an(an));


endmodule
