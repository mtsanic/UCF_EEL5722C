module seven_segment_controller(
    clk_1kHz,  //|<i
    rst,        //|<i
    dec,       //|<i
    seg,        //|>o
    an          //|>o
);

input clk_1kHz;
input [3:0] dec;
input rst;
output reg [6:0] seg;
output [3:0] an;

wire [6:0] w_s_sgmt0;

seven_segment_decoder ssd0(.dec(dec), .seven_segment(w_s_sgmt0));

always @(posedge clk_1kHz or posedge rst) begin
    if(rst) begin
        seg=7'b1111111;
    end
    else begin
        seg=w_s_sgmt0;
    end
end


endmodule