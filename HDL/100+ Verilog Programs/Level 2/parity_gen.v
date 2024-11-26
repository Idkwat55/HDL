`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2024 13:58:20
// Design Name: 
// Module Name: parity_gen
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


module parity_gen(
input wire [3:0] d,
output wire even_p, odd_p
    );
    
    assign even_p = ^d;
    assign odd_p = ~even_p;
    
endmodule
