`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 14:35:16
// Design Name: 
// Module Name: comp4b
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


module comp4b(
input [3:0] a,b,
output z,x,y
    );
    // z - a>b , x - a <b , y - a == b

    assign z = (a>b) ? 1 : 1'bx;
    assign x = (a<b) ? 1 : 1'bx;
    assign y = (a==b) ? 1 : 1'bx;  

endmodule
