`timescale 1ns / 1ps

module ps2_rx_tb;
reg clk;
reg rst;
reg PS2Clk;
reg PS2Data;
wire [7:0] c_data;

ps2_rx DUT0(.clk(clk), .rst(rst), .PS2Clk(PS2Clk), .PS2Data(PS2Data), .c_data(c_data));

initial begin
    clk=0;
    rst=1;
    PS2Clk=1;
    PS2Data=0;
    #10

    rst=0;
    #5
    PS2Data=0;
    #5
    PS2Data=1;
    #5
    PS2Data=0;
    #5
    PS2Data=1;
    #5
    PS2Data=0;
    #5
    #3
    PS2Data=0;
    #5
    PS2Data=0;
    #5
    PS2Data=1;
    #5
    #1
    PS2Data=0;
    #5
    #1
    PS2Data=0;
    #5
    PS2Data=1;

    #3
    $finish;
end

always begin
        #1 clk=~clk;
end

always begin
    #3 PS2Clk=~PS2Clk;
end


endmodule
