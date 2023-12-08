`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
// Decoder to 7segment display Controller
//
//////////////////////////////////////////////////////////////////////////////////

module seven_segment_decoder (
    dec,            //|<i
    seven_segment   //|>o
);

input [3:0] dec;
output reg [6:0] seven_segment;
always @(*) begin
    case(dec)
        4'b0000: seven_segment=7'b1000000;
        4'b0001: seven_segment=7'b1111001;
        4'b0010: seven_segment=7'b0100100;
        4'b0011: seven_segment=7'b0110000;
        4'b0100: seven_segment=7'b0011001;
        4'b0101: seven_segment=7'b0010010;
        4'b0110: seven_segment=7'b0000010;
        4'b0111: seven_segment=7'b1111000;
        4'b1000: seven_segment=7'b0000000;
        4'b1001: seven_segment=7'b0010000; 
        default: seven_segment=7'b1000000;
    endcase
end
 
endmodule