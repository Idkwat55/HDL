`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.11.2024 21:39:58
// Design Name: 
// Module Name: half_subtractor
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

module half_subtractor(
    input a,
    input b,
    output difference,
    output borrow
);
    assign difference = a ^ b;  // XOR for difference
    assign borrow = ~a & b;     // AND and NOT for borrow
endmodule

