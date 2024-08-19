`timescale 1ns / 1ps

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
