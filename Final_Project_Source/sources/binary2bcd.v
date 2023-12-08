`timescale 1ns / 1ps

module binary2bcd(
   input clk, reset, start,
   input [13:0] in,
   output [3:0] bcd3, bcd2, bcd1, bcd0,
   output [3:0] count,
   output [1:0] state
);

   localparam  IDLE        = 2'b00,
               INIT        = 2'b01,
               SHIFT       = 2'b10,
               CHECK       = 2'b11;

   reg [15:0] bcd_reg=0;
   reg [4:0] count_reg=0;
   reg [31:0] temp_reg=0;
   reg [1:0] state_reg=0;


   always @(posedge clk, posedge reset) begin
      if(reset) begin
         bcd_reg     <=0;
         count_reg   <=0;
         temp_reg    <=0;
         state_reg   <=IDLE;
      end
      else begin
         case (state_reg)
            IDLE  : begin
                     bcd_reg  <= bcd_reg; 
                     temp_reg <= 0; 
                     if(start) begin 
                        state_reg   <= INIT; 
                     end 
                     else begin 
                        state_reg   <= IDLE; 
                     end
            end

            INIT  : begin
                     bcd_reg  <= bcd_reg;
                     temp_reg <= {18'h00000, in};
                     state_reg<= SHIFT;
            end

            SHIFT :  begin
                        bcd_reg  <=bcd_reg;
                        temp_reg <={temp_reg[30:0], 1'b0};
                        count_reg<=count_reg+1;
                        state_reg<=CHECK;
            end

            CHECK :  begin
                        if(count_reg!=16) begin
                           bcd_reg<=bcd_reg;
                           if(temp_reg[31:28]>4) begin
                              temp_reg[31:28]<=temp_reg[31:28]+3;
                           end
                           if(temp_reg[27:24]>4) begin
                              temp_reg[27:24]<=temp_reg[27:24]+3;
                           end
                           if(temp_reg[23:20]>4) begin
                              temp_reg[23:20]<=temp_reg[23:20]+3;
                           end
                           if(temp_reg[19:16]>4) begin
                              temp_reg[19:16]<=temp_reg[19:16]+3;
                           end
                           state_reg<=SHIFT;
                        end
                        else begin
                           bcd_reg<=temp_reg[31:16];
                           temp_reg<=0;
                           count_reg<=0;
                           state_reg<=IDLE;
                        end
            end
         endcase
      end

   end


   assign count=count_reg;
   assign state=state_reg;
   assign bcd0=bcd_reg[3:0];
   assign bcd1=bcd_reg[7:4];
   assign bcd2=bcd_reg[11:8];
   assign bcd3=bcd_reg[15:12];

endmodule