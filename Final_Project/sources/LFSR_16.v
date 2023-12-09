`timescale 1ns / 1ps

module LFSR_16(
    input clk,
    input rst,
    input w_en,
    input [15:0] w_in,
    output [15:0] out
);


    reg [15:0] r_LFSR;
     
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            r_LFSR<=w_in;
        end
        else begin
            if(w_en==1) begin
                r_LFSR<=r_LFSR<<1;
                r_LFSR[0]<= r_LFSR[15]^~r_LFSR[14]^~r_LFSR[12]^~r_LFSR[3];
            end
        end
    end

    assign out = r_LFSR;

endmodule

