`timescale 1ns / 1ps

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
        4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110, 4'b1111: seven_segment=7'b1111111; 
        default: seven_segment=7'b1111111;
    endcase
end
 
endmodule
