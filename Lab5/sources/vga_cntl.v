`timescale 1ns / 1ps


module vga_cntl(
    clk_50MHz,  //|<i
    rst,        //|<i
    Hsync,      //|>o
    Vsync,      //|>o
    x_pos,      //|>o
    y_pos       //|>o
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

    input clk_50MHz;
    input rst;
    output Hsync;
    output Vsync;
    output [9:0] x_pos;
    output [9:0] y_pos;

    reg [9:0] row_pix=0;
    reg [9:0] col_pix=0;


    always @(posedge clk_50MHz or posedge rst) begin
        if (rst) begin
            col_pix=0;
            row_pix=0;
        end
        else begin
            if(row_pix==(h_pixel-1)) begin
                if(col_pix==(v_pixel-1)) begin
                    col_pix=0;
                    row_pix=0;
                end
                else begin
                    col_pix=col_pix+1;
                    row_pix=0;
                end
            end
            else begin
                row_pix=row_pix+1;
            end
        end
    end


    assign Hsync=(row_pix< h_pulse)? 0:1;
    assign Vsync =(col_pix < v_pulse)? 0:1;

    assign x_pos=row_pix;
    assign y_pos=col_pix;


endmodule
