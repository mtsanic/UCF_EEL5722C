`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 11:53:07 AM
// Design Name: 
// Module Name: led_cntl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led_cntl(
    clk_20Hz,   //|<i
    rst,        //|<i
    btnU,       //|<i
    leds        //|>o
);

    input clk_20Hz;
    input btnU;
    input rst;
    output reg [2:0] leds;

    initial begin
        leds=0;
    end

    always @(posedge clk_20Hz or posedge rst) begin
        if(rst) begin
            leds=0;
        end
        else begin
            if (btnU) begin
                leds=leds+1;
            end
        end
    end


endmodule
