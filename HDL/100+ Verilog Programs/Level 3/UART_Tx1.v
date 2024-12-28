 
 module UART_Tx(
 input wire [7:0] din,
 input wire clk, rst_, en, bt,
 output reg dout
 );
 
 localparam start = 2'b00;
 localparam stop  = 2'b01;
 localparam idle  = 2'b11;
 localparam dataTx = 2'b10;
 
 
 reg [7:0] counter, tmp;
 reg [1:0] state;
 
 always@(posedge clk or negedge rst_) begin
     if (!rst_) begin
         dout <= idle[0];
         counter <= 'b0;
         tmp <= 'b0;
         state <= idle;
     end
     else if (en) begin
         
         case (state)
             idle: begin
                 if (bt) begin
                    tmp <= din;
                    state<= start;
                 end
                 else 
                    dout <= idle[0];
                
             end
             
             start : begin
                 dout <= start[0];
                 state <= dataTx;
                 counter <= 'b0; 
             end
             
             dataTx : begin
             
                 if (counter < 'b1001) begin
                     dout <= tmp[0];
                     tmp <= tmp >> 1;
                 if (counter == 'b1000) begin
                    dout<= idle[0];
                 end
                    counter <= counter + 1;
                 end
                 else  begin
                     state <= idle;
                     dout<= idle[0];
                 end
             end
             
             stop : begin
                state <= idle;
             end
             
             default: state<= idle;
             
         endcase
         end
     end
     
 
 endmodule