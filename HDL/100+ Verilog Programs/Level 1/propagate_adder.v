`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2024 22:27:34
// Design Name: 
// Module Name: propagate_adder
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


module propagate_adder(
input [3:0] a,b,
input cin,
output reg [3:0] sum,
output reg carry
    );
    
    // g_i  = a_i & b_i 
    // p_i  = a_i ^ b_i 
    // s_i  = p_i ^ c_i
    // c_1+1= g_i | (c_i & p_i)
 
reg [2:0] i = 0 ;
reg [3:0] g,p;
reg [4:0] c;
 
always@(a or b or cin) begin
c = 5'b00000;;
c[0] = cin;

for (i = 0; i<4; i = i + 1) begin
g[i] = a[i] & b[i];
p[i] = a[i] ^ b[i];
sum[i] = p[i] ^ c[i];
c[i+1] = g[i] | (c[i] & p[i]);
end
carry = c[4];
end   
  
    
endmodule
