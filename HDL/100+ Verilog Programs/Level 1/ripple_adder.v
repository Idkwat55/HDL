`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2024 22:27:34
// Design Name: 
// Module Name: ripple_adder
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

//Ripple carry Adders - RCA - uses full adders in a sequential order

module ripple_adder(
input [3:0] a,b,
input cin,
output [3:0] sum,
output carry
    );
    
    wire w1,w2,w3;
    
    full_adder fa1 (a[0] , b[0], cin , sum[0] ,w1 );
    full_adder fa2 (a[1] , b[1], w1 , sum[1] ,w2 );
    full_adder fa3 (a[2] , b[2], w2 , sum[2] ,w3 );
    full_adder fa4 (a[3] , b[3], w3 , sum[3] ,carry );
    
endmodule
