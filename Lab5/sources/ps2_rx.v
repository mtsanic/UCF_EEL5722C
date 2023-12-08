`timescale 1ns / 1ps

module ps2_rx(
    clk,
    rst,
    PS2Clk,
    PS2Data,
    c_data
);
    input clk;
    input rst;
    input PS2Clk;
    input PS2Data;
    output reg [7:0] c_data;

    reg [10:0] store=0;
    reg [3:0] count=0;
    reg [7:0] temp;
    wire parity_check;

    always @(negedge PS2Clk or posedge rst) begin
        if (rst) begin
            count<=0;
            store<=0;
        end
        else begin
            if(count<10) begin
                store[count]<=PS2Data;
                count<=count+1;
            end
            else begin
                count<=0;
            end
        end
    end

    assign parity_check=~(store[1]^store[2]^store[3]^store[4]^store[5]^store[6]^store[7]^store[8]);

    always @(posedge clk) begin
            if ((store[0]==0) && (parity_check==store[9])) begin
            temp<=store[8:1];
            if(temp==store[8:1]) begin
                c_data<=0;
            end
            else begin
                c_data=store[8:1];
            end
            end
            
    end

endmodule
