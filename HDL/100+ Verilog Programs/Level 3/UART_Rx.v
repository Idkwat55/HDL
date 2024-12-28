`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.12.2024 14:52:29
// Design Name: 
// Module Name: UART_Rx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module UART_Rx(
input wire Din, clk, rst_,
output reg [7:0] Dout,
output reg  Dvalid
    );
  
localparam start = 'b00;
localparam receive= 'b01;
localparam stop = 'b10;  
    
parameter baud_rate = 'd1042 ; // 9600 baud, actual 9,596.1
parameter half_rate ='d521;
parameter bits_per_frame = 'd8;

reg [7:0] data_reg;
reg [15:0] baud_counter; 
reg [4:0] bit_counter;
reg [2:0] state;
    
    
    always@(posedge clk or negedge rst_) begin
    
    if (!rst_) begin
    Dout <= 0;
    Dvalid<=0;
    state<=stop;
    bit_counter<=0;
    baud_counter<=0;
    data_reg<=0;
    end
 
   else begin
   case (state)
    
    stop: begin
    bit_counter<= 0;
    Dvalid <= 0;
    if (Din == 0) begin
    baud_counter <= baud_counter + 1;
    if(baud_counter == half_rate) begin
    baud_counter <= 0;
    state<= start;
    end 
    end 
    else
    baud_counter <= 0;
    
    end
    
    start: begin
    baud_counter <= baud_counter + 1;
    if (baud_counter == baud_rate) begin
    baud_counter <= 0;
    state <= receive;
    end
    end
    
      receive: begin
    data_reg[7]<= Din;
    baud_counter <= baud_counter + 1;
    if (baud_counter == baud_rate) begin
    if ( ( bit_counter + 1 )== bits_per_frame) begin
    Dout <= data_reg;
    Dvalid <= 1;
    state <= stop;
    end else
    data_reg <= data_reg >> 1;
    baud_counter <= 0;
    bit_counter <= bit_counter + 1;
    end
    end
    
    endcase
   
   
   end
    
    end
    
endmodule
