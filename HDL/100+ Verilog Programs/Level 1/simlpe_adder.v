`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2024 22:27:34
// Design Name: 
// Module Name: simlpe_adder
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


module simple_adder(
input [3:0] a,b,
input carry_in,
output [3:0] sum,
output carry
    );
 
assign {carry,sum} = a + b + carry_in;   
    
endmodule
