`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2024 13:58:20
// Design Name: 
// Module Name: johnson_counter
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


module johnson_counter(
 
input wire clk, rst_,
output reg  [3:0] q
    );
 
always@(posedge clk or negedge rst_) begin
if (!rst_) 
q <= 4'b0000;
else begin
q[3] <= q[2] ;
q[2] <= q[1];
q[1] <= q[0];
q[0] <= ~q[3];
end
end 
    
endmodule
