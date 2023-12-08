`timescale 1ns / 1ps

module seven_segment_decoder(
    dec,            //|<i
    seven_segment   //|>o
);

input [2:0] dec;
output reg [6:0] seven_segment;
always @(*) begin
    case(dec)
        0: seven_segment=7'b1000000;
        1:seven_segment=7'b1111001;
        2: seven_segment=7'b0100100;
        3: seven_segment=7'b0110000;
        4: seven_segment=7'b0011001;
        5: seven_segment=7'b0010010;
        6: seven_segment=7'b0000010;
        7: seven_segment=7'b1111000;
        default: seven_segment=7'b1000000;
    endcase
end

endmodule
