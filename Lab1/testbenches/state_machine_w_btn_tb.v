`timescale 1ns / 1ps

module state_machine_w_btn_tb;

reg clk_10Hz;
reg [1:0] btn;
wire [3:0] dec0;
wire [3:0] dec1;

state_machine_w_btn dut0(.clk_10Hz(clk_10Hz), .btn(btn), .dec0(dec0), .dec1(dec1));

initial begin
    clk_10Hz=0;
    btn=0;
    #5
    btn=1;
    #10
    btn=2;
    #10
    btn=3;
    #15
    btn=0;
    #15
    $finish;
end

always begin
    #1 clk_10Hz=~clk_10Hz;
end



endmodule
