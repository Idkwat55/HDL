`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2024 19:19:53
// Design Name: 
// Module Name: bin2gray
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


module bin2gray(
input wire  [3:0] a,
output wire [3:0] y
    );
    
    assign y = a ^ (a >> 1);
    
endmodule
