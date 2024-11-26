`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2024 19:19:53
// Design Name: 
// Module Name: gray2bin
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


module gray2bin(
input wire [3:0] g,
output wire [3:0] b
    );
    
    assign b[3] = g[3];
    assign b[2] = g[3] & g[2];
    assign b[1] = g[2] & g[1];
    assign b[0] = g[1] & g[0];
     
    
endmodule
