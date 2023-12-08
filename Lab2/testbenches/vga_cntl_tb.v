`timescale 1ns / 1ps

module vga_cntl_tb;

reg clk_50MHz;  //|<i
reg    rst;        //|<i
wire   Hsync;      //|>o
wire    Vsync;      //|>o
wire [9:0]   x_pos;      //|>o
wire [9:0]   y_pos;       //|>o

vga_cntl DUT0(.clk_50MHz(clk_50MHz), .rst(rst), .Hsync(Hsync), .Vsync(Vsync), .x_pos(x_pos), .y_pos(y_pos));


initial begin
    clk_50MHz=0;
    forever #1 clk_50MHz=~clk_50MHz;
end

initial begin
    rst=1;
    #20
    rst=0;
end



endmodule
