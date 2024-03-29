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
    wire [7:0] douta;
    wire [7:0] doutb;
    wire [7:0] dip_douta;
    wire [7:0] dip_doutb;

    wire kb_pressed;
    wire scan_start;
    wire scan_end;
    wire filter_start;
    wire filter_end;

    //registers
    reg [15:0] addra=0;
    reg [7:0] dina=0;
    reg [15:0] addrb=0;
    reg [7:0] dinb=0;
    reg wea=0;
    reg web=0;
    reg [15:0] dip_addra=0;
    reg [7:0] dip_dina=0;
    reg [15:0] dip_addrb=0;
    reg [7:0] dip_dinb=0;
    reg dip_wea=0;
    reg dip_web=0;
    reg [3:0]  dec=0;
    reg [8:0]  i=0;
    reg [4:0]  j=0;
    reg [18:0] kb_state=0;
    reg [17:0] scan_state=0;
    reg [3:0] filter_state=0;
    reg [16:0] ram_state=0;
    reg display_state=0;
    reg [7:0] pixels [8:0];
    reg [9:0] filtered_pixel=0;



    blk_mem_gen_0 bram0(.clka(clk), .wea(wea),      .addra(addra),      .dina(dina),        .douta(douta),      .clkb(clk), .web(web),      .addrb(addrb),      .dinb(dinb),        .doutb(doutb));
    blk_mem_gen_0 bram1(.clka(clk), .wea(dip_wea),  .addra(dip_addra),  .dina(dip_dina),    .douta(dip_douta),  .clkb(clk), .web(dip_web),  .addrb(dip_addrb),  .dinb(dip_dinb),    .doutb(dip_doutb));
    clk_gen_50MHz clk_gen_50MHz_0(.clk(clk), .rst(rst), .clk_50MHz(clk_50MHz));
    ps2_rx ps2_rx0(.clk(clk), .rst(rst), .PS2Clk(PS2Clk), .PS2Data(PS2Data), .c_data(c_data));
    vga_cntl vga_cntl0(.clk_50MHz(clk_50MHz), .rst(rst), .Hsync(Hsync), .Vsync(Vsync), .x_pos(x_pos), .y_pos(y_pos));

    assign kb_pressed = (c_data==8'h45)?1:0;
    assign scan_start = (kb_state==1)?1:0;
    assign filter_start = (scan_state[1:0]==1)?1:0;
    assign filter_end = (filter_state==15)?1:0;
    assign scan_end = (scan_state==262143)?1:0;

    always @(posedge clk) begin
        case (kb_state)
            0: begin if(kb_pressed==1) begin kb_state<=kb_state+1; end end
            1: begin kb_state<=kb_state+1; end
            2: begin if(scan_end==1) begin kb_state<=kb_state+1; end end
            500000 : begin kb_state<=0; end
            default: kb_state<=kb_state+1;
        endcase
    end

    always @(posedge clk) begin
        case (scan_state[1:0])
            0: begin if(scan_start==1 || scan_state>3) begin scan_state<=scan_state+1; end end
            1: begin scan_state<=scan_state+1; end
            2: begin if(filter_end==1) begin scan_state<=scan_state+1; end end
            3: begin scan_state<=scan_state+1;  end
            default: scan_state<=scan_state+1;
        endcase
    end

    always @(posedge clk) begin
        case (filter_state)
            0 : begin if(filter_start==1) begin filter_state<=filter_state+1; end end
            1 : begin addra<=scan_state[17:2]-257; filter_state<=filter_state+1; end
            2 : begin addra<=addra+1; pixels[0]<=douta; filter_state<=filter_state+1; end
            3 : begin addra<=addra+1; pixels[1]<=douta; filter_state<=filter_state+1; end
            4 : begin addra<=addra+254; pixels[2]<=douta; filter_state<=filter_state+1; end
            5 : begin addra<=addra+1; pixels[3]<=douta; filter_state<=filter_state+1; end
            6 : begin addra<=addra+1; pixels[4]<=douta; filter_state<=filter_state+1; end
            7 : begin addra<=addra+254; pixels[5]<=douta; filter_state<=filter_state+1; end
            8 : begin addra<=addra+1; pixels[6]<=douta; filter_state<=filter_state+1; end
            9 : begin addra<=addra+1; pixels[7]<=douta; filter_state<=filter_state+1; end
            10: begin addra<=addra-257; pixels[8]<=douta; filter_state<=filter_state+1; end
            11: begin filtered_pixel<=((pixels[0]+pixels[1]+pixels[2]+pixels[3]+pixels[4]+pixels[5]+pixels[6]+pixels[7]+pixels[8])*7)>>6; filter_state<=filter_state+1; end
            12: begin dip_addrb<=addra; filter_state<=filter_state+1; end
            13: begin dip_dinb<=filtered_pixel[7:0]; dip_web<=1; filter_state<=filter_state+1; end //filter_state<=15;
            14: begin filter_state<=filter_state+1; dip_web<=0; end
            15: begin filter_state<=filter_state+1; end
            default: filter_state<=filter_state+1;
        endcase

        if(scan_state==0) begin
            case (display_state)
                0: begin addra<=(x_pos-144)*256+(y_pos-31); display_state<=display_state+1; end
                1: begin if(x_pos>143 && x_pos<401 && y_pos>30 && y_pos<288) begin
                            vgaRed<=douta[7:4];
                            vgaGreen<=douta[7:4];
                            vgaBlue<=douta[7:4];
                         end
                         else begin
                            vgaRed<=0;
                            vgaGreen<=0;
                            vgaBlue<=0;
                         end
                        display_state<=display_state+1; 
                    end
            endcase
        end
    end

    always @(posedge clk) begin
        case (ram_state)
            0: begin begin ram_state<=ram_state+1; addrb<=0; dip_addra<=0; web<=1; end end
            //1: begin  dinb<=dip_douta; ram_state<=ram_state+1;  end
            //2: begin  end
            65538: begin web<=0; ram_state<=0; end
            default: begin addrb<=addrb+1; dip_addra<=dip_addra+1; dinb<=dip_douta; ram_state<=ram_state+1; end
        endcase
    end



endmodule
