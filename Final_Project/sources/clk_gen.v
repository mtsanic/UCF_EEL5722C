`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
// Clock Generation for 50MHz
//
//////////////////////////////////////////////////////////////////////////////////

//Clock Divider for 50MHz
//Used for VGA display
module clk_gen_50MHz(
    clk,        //|<i
    rst,        //|<i
    clk_50MHz   //|>o
    );

input clk;
input rst;
output reg clk_50MHz;

reg [1:0] counter;

initial begin
    clk_50MHz<=0;
    counter<=0;
end

always @(posedge clk ) begin
    if (rst) begin
        clk_50MHz<=0;
        counter<=0;
    end
    else begin
       if(counter==1) begin   //100M/(2)=50MHz
            clk_50MHz=~clk_50MHz;
            counter=0;
        end
        else begin
            counter=counter+1;
        end 
    end   
end

endmodule
