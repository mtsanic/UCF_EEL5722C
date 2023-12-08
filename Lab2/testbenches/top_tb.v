`timescale 1ns / 1ps

module top_tb;

    reg clk;
    reg rst;
    reg btnU;
    wire [6:0] seg;
    wire [3:0] an;
    wire [3:0] vgaRed;
    wire [3:0] vgaGreen;
    wire [3:0] vgaBlue;
    wire Hsync;
    wire Vsync;

    top DUT0(.clk(clk),.rst(rst), .btnU(btnU), .seg(seg), .an(an), .vgaRed(vgaRed), .vgaBlue(vgaBlue), .vgaGreen(vgaGreen),.Hsync(Hsync),.Vsync(Vsync));

    initial begin
        rst=1;
        btnU=0;
        clk=0;

        #10
        rst=0;
        btnU=1;
    end

    always begin
        #1 clk<=~clk;
    end

endmodule
