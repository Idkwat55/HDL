`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 14:35:16
// Design Name: 
// Module Name: decoder2to4
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


module decoder2to4(
input a,b,
output q0,q1,q2,q3
    );
    
    assign q0 = ~a & ~b;
    assign q1 = ~a & b;
    assign q2 = a & ~b;
    assign q3 = a & b;
    
endmodule
