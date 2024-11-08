`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 14:35:16
// Design Name: 
// Module Name: decoder3to8
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


module decoder3to8(
input a,b,c,
output q0,q1,q2,q3,q4,q5,q6,q7
    );
    
    assign q0 = ~a & ~b & ~c ;
    assign q1 = ~a & ~b & c;
    assign q2 = ~a & b & ~ c;
    assign q3 = ~a & b & c;
    assign q4 = a & ~b & ~c;
    assign q5 = a & ~b & c;
    assign q6 = a & b & ~c;
    assign q7 = a & b & c;
    
endmodule
