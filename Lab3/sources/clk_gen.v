`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// 
// Clock Generation for 10Hz and 500Hz
//
//////////////////////////////////////////////////////////////////////////////////

//Clock Divider for 10Hz
//Used for Decoder control
module clk_gen_20Hz(
    clk,        //|<i
    rst,        //|<i
    clk_20Hz    //|>o
    );

input clk;
input rst;
output reg clk_20Hz;

reg [22:0] counter;

initial begin
    clk_20Hz<=0;
    counter<=0;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter<=0;
        clk_20Hz<=0;
    end
    else begin
        if(counter==4_999_999) begin    //100M/(5M)=20Hz
            clk_20Hz<=~clk_20Hz;
            counter<=0;
        end
        else begin
            counter<=counter+1;
        end
    end
end


endmodule

//Clock Divider for 1kHz
//Used for 7segment display
module clk_gen_1kHz(
    clk,        //|<i
    rst,        //|<i
    clk_1kHz    //|>o
    );

input clk;
input rst;
output reg clk_1kHz;

reg [16:0] counter;

initial begin
    clk_1kHz<=0;
    counter<=0;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        counter<=0;
        clk_1kHz<=0;
    end
    else begin
        if(counter==99_999) begin   //100M/(100k)=1kHz
            clk_1kHz<=~clk_1kHz;
            counter<=0;
        end
        else begin
            counter<=counter+1;
        end
    end
end

endmodule


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
       if(counter==1) begin   //100M/(2*2)=25MHz
            clk_50MHz=~clk_50MHz;
            counter=0;
        end
        else begin
            counter=counter+1;
        end 
    end   
end

endmodule
