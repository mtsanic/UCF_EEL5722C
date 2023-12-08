`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//  
// Seven Segment Controller
// 
//////////////////////////////////////////////////////////////////////////////////


module seven_segment_controller(
    clk_500Hz,  //|<i
    dec0,       //|<i
    dec1,       //|<i
    s_sgmt,     //|>o
    an          //|>o
);

input clk_500Hz;
input [3:0] dec0;
input [3:0] dec1;
output reg [6:0] s_sgmt;
output reg [3:0] an;

wire [6:0] w_s_sgmt0;
wire [6:0] w_s_sgmt1;

reg state;

initial begin
    state<=0;
end

seven_segment_decoder ssd0(.dec(dec0), .seven_segment(w_s_sgmt0));
seven_segment_decoder ssd1(.dec(dec1), .seven_segment(w_s_sgmt1));

always @(posedge clk_500Hz ) begin
    state<=~state;
end

always @(state) begin
    case (state)
        0   :   an<=4'b1110;
        1   :   an<=4'b1101;  
    endcase
end

always @(*) begin
    case (state)
        0   :   s_sgmt<=w_s_sgmt0;
        1   :   s_sgmt<=w_s_sgmt1; 
    endcase
end


endmodule
