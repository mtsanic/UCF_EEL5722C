`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//  
// State Machines for Decoder control
// 
//////////////////////////////////////////////////////////////////////////////////

//State Machine for Button Controller
module state_machine_w_btn(
    clk_10Hz,   //|<i
    btn,        //|<i
    dec0,       //|>o
    dec1        //|>o
);

input clk_10Hz;
input [1:0] btn;
output reg [3:0] dec0;
output reg [3:0] dec1;

initial begin
    dec0<=0;
    dec1<=0;
end

always @(posedge clk_10Hz ) begin
    case (btn)
        0   :   begin dec0<=dec0; dec1<=dec1; end 
        1   :   begin dec0<=(dec0+1)%10; dec1<=dec1; end 
        2   :   begin dec0<=dec0; dec1<=(dec1+1)%10; end 
        3   :   begin dec0<=(dec0+1)%10; dec1<=(dec1+1)%10; end 
        default: begin dec0<=dec0; dec1<=dec1; end 
    endcase
end

endmodule

//State Machine for Clock Controller
module state_machine_w_clk(
    clk_10Hz,   //|<i
    dec0,       //|>o
    dec1        //|>o
);

input clk_10Hz;
output reg [3:0] dec0;
output reg [3:0] dec1;

initial begin
    dec0<=0;
    dec1<=0;
end

always @(posedge clk_10Hz ) begin
    if(dec0==9) begin
        if(dec1==9) begin
            dec1<=0;
        end
        else begin
            dec1<=dec1+1;
        end
        dec0<=0;  
    end
    else begin
        dec0<=dec0+1;
    end
end

endmodule
