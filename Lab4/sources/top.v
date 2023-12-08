`timescale 1ns / 1ps


module top(
    clk,        //|<i
    rst,        //|<i
    PS2Clk,     //|<i
    PS2Data,    //|<i
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

    //inputs
    input clk;
    input rst;
    input PS2Clk;
    input PS2Data;
    //outputs
    output reg [3:0] vgaRed;
    output reg [3:0] vgaBlue;
    output reg [3:0] vgaGreen;
    output Hsync;
    output Vsync;

    //wires
    wire clk_50MHz;
    wire [9:0] x_pos;
    wire [9:0] y_pos;
    wire [7:0] c_data;
    wire [23:0] douta;

    //registers
    reg [10:0] addra=0;
    reg [3:0]  dec=0;
    reg [4:0]  i=0;
    reg [4:0]  j=0;

    blk_mem_gen_0 brom0(.clka(clk),.addra(addra),.douta(douta));
    clk_gen_50MHz clk_gen_50MHz_0(.clk(clk), .rst(rst), .clk_50MHz(clk_50MHz));
    ps2_rx ps2_rx0(.clk(clk), .rst(rst), .PS2Clk(PS2Clk), .PS2Data(PS2Data), .c_data(c_data));
    vga_cntl vga_cntl0(.clk_50MHz(clk_50MHz), .rst(rst), .Hsync(Hsync), .Vsync(Vsync), .x_pos(x_pos), .y_pos(y_pos));


    always @(posedge clk or posedge rst) begin
        if (rst) begin
            vgaRed<=0;
            vgaGreen<=0;
            vgaBlue<=0;
            addra<=0;
        end
        else begin
            if(x_pos>143 && x_pos<152 && y_pos>30 && y_pos<47) begin
                addra<=dec*128+(x_pos-144)+(y_pos-31)*8;
                vgaRed<=douta[23:20];
                vgaGreen<=douta[15:12];
                vgaBlue<=douta[7:4];
            end
            else begin
                vgaRed<=0;
                vgaGreen<=0;
                vgaBlue<=0;
            end
        end
    end

    always @(c_data) begin
        case (c_data)
            8'h45 : dec<=0;         //0
            8'h16 : dec<=1;         //1
            8'h1E : dec<=2;         //2
            8'h26 : dec<=3;         //3
            8'h25 : dec<=4;         //4
            8'h2E : dec<=5;         //5
            8'h36 : dec<=6;         //6
            8'h3D : dec<=7;         //7
            8'h3E : dec<=8;         //8
            8'h46 : dec<=9;         //9
            8'h5A : dec<=11;        //ENTER
            default: dec<=10;       //Anything Else
        endcase
    end



endmodule
