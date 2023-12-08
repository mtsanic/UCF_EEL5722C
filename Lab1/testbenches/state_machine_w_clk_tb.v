`timescale 1ns / 1ps
module state_machine_w_clk_tb;

reg clk_10Hz;
wire [3:0] dec0;
wire [3:0] dec1;



state_machine_w_clk dut0(.clk_10Hz(clk_10Hz), .dec0(dec0), .dec1(dec1));

initial begin
    clk_10Hz<=0;
end

always begin
    #1 clk_10Hz=~clk_10Hz;
end



endmodule
