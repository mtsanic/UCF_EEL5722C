`timescale 1ns / 1ps


module vga_sync(
    clk,  //|<i
    reset,        //|<i
    hsync,      //|>o
    vsync,      //|>o
    display_on,  //|>o
    p_tick,
    x,      //|>o
    y       //|>o
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
    input reset;
    output hsync;
    output vsync;
    output display_on;
    output p_tick;
    output [9:0] x;
    output [9:0] y;

    reg [9:0] row_pix=0;
    reg [9:0] col_pix=0;

    clk_gen_50MHz inst0(clk, reset, p_tick);

    always @(posedge p_tick or posedge reset) begin
        if (reset) begin
            col_pix=0;
            row_pix=0;
        end
        else begin
            if(col_pix==(h_pixel-1)) begin
                if(row_pix==(v_pixel-1)) begin
                    row_pix=0;
                    col_pix=0;
                end
                else begin
                    row_pix=row_pix+1;
                    col_pix=0;
                end
            end
            else begin
                col_pix=col_pix+1;
            end
        end
    end


    assign hsync=(col_pix< h_pulse)? 0:1;
    assign vsync =(row_pix < v_pulse)? 0:1;
    assign display_on=hsync&vsync;

    assign x=col_pix-h_fp-h_bp+8;
    assign y=row_pix-v_fp-v_bp;


endmodule
