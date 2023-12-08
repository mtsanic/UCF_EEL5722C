`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
// Clock Generation for 10Hz and 500Hz
//
//////////////////////////////////////////////////////////////////////////////////

//Clock Divider for 10Hz
//Used for Decoder control
module clk_gen_10HZ(
    clk,        //|<i
    clk_10Hz    //|>o
    );

input clk;
output reg clk_10Hz;

reg [22:0] counter;

initial begin
    clk_10Hz<=0;
    counter<=0;
end

always @(posedge clk ) begin
    if(counter==4_999_999) begin    //100M/(5M*2)=10Hz
        clk_10Hz<=~clk_10Hz;
        counter<=0;
    end
    else begin
        counter<=counter+1;
    end
end


endmodule

//Clock Divider for 500Hz
//Used for 7segment display
module clk_gen_500Hz(
    clk,        //|<i
    clk_500Hz    //|>o
    );

input clk;
output reg clk_500Hz;

reg [16:0] counter;

initial begin
    clk_500Hz<=0;
    counter<=0;
end

always @(posedge clk ) begin
    if(counter==99_999) begin   //100M/(100k*2)=500Hz
        clk_500Hz<=~clk_500Hz;
        counter<=0;
    end
    else begin
        counter<=counter+1;
    end
end


endmodule
