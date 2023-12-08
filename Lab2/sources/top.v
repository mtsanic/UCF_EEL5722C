`timescale 1ns / 1ps




module top(
    clk,        //|<i
    rst,        //|>i
    btnU,       //|<i
    seg,        //|>o
    an,         //|>o
    vgaRed,     //|>o
    vgaBlue,    //|>o
    vgaGreen,   //|>o
    Hsync,      //|>o
    Vsync       //|>o
);

    localparam h_pixel   = 800;
    localparam h_display = 640;
    localparam h_pulse   = 96;
    localparam h_fp      = 16;
    localparam h_bp      = 48;

    localparam v_pixel   = 521;
    localparam v_display = 480;
    localparam v_pulse   = 2;
    localparam v_fp      = 10;
    localparam v_bp      = 29;

    input clk;
    input rst;
    input btnU;
    output [6:0] seg;
    output [3:0] an;
    output reg [3:0] vgaRed;
    output reg [3:0] vgaBlue;
    output reg [3:0] vgaGreen;
    output Hsync;
    output Vsync;

    wire clk_20Hz, clk_1kHz, clk_50MHz;
    wire [2:0] leds;
    wire [9:0] x_pos;
    wire [9:0] y_pos;


    assign an=4'b1110;

    clk_gen_20Hz clk_gen_20Hz_0(.clk(clk), .rst(rst), .clk_20Hz(clk_20Hz));
    clk_gen_1kHz clk_gen_1kHz_0(.clk(clk), .rst(rst), .clk_1kHz(clk_1kHz));
    clk_gen_50MHz clk_gen_50MHz_0(.clk(clk), .rst(rst), .clk_50MHz(clk_50MHz));
    led_cntl led_cntl0(.clk_20Hz(clk_20Hz), .rst(rst), .btnU(btnU), .leds(leds));
    seven_segment_controller seven_segment_controller(.clk_1kHz(clk_1kHz), .rst(rst), .leds(leds), .seg(seg), .an(an));
    vga_cntl vga_cntl0(.clk_50MHz(clk_50MHz), .rst(rst), .Hsync(Hsync), .Vsync(Vsync), .x_pos(x_pos), .y_pos(y_pos));
    

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            vgaRed<=0;
            vgaBlue<=0;
            vgaGreen<=0;
        end
        else begin
            if(x_pos<(h_pulse+h_bp) || x_pos>=(h_pixel-h_fp) || y_pos<(v_pulse+v_bp) || y_pos>=(v_pixel-v_fp)) begin
                vgaRed<=0;
                vgaBlue<=0;
                vgaGreen<=0;
            end 
            else begin
            case (leds)
                0 :         begin   vgaRed<=0;    vgaBlue<=0;     vgaGreen=0;  end 
                1 :         begin   vgaRed<=15;   vgaBlue<=0;     vgaGreen=0;  end 
                2 :         begin   vgaRed<=0;    vgaBlue<=15;    vgaGreen=0;  end 
                3 :         begin   vgaRed<=0;    vgaBlue<=0;     vgaGreen=15; end 
                4 :         begin   vgaRed<=15;   vgaBlue<=15;    vgaGreen=15; end 
                5 :         begin   vgaRed<=8;    vgaBlue<=9;     vgaGreen=10; end 
                6 :         begin   vgaRed<=9;    vgaBlue<=11;    vgaGreen=4;  end 
                7 :         begin   vgaRed<=13;   vgaBlue<=3;     vgaGreen=10; end   
                default:    begin   vgaRed<=0;    vgaBlue<=0;     vgaGreen=0;  end
            endcase
            end
        end
    end



endmodule
