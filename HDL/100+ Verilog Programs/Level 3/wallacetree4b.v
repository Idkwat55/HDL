`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 15:29:06
// Design Name: 
// Module Name: wallacetree4b
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


module wallacetree4b_adder(
input wire signed [3:0] a,b,
output reg signed [7:0] p
);

reg [7:0] pp0,pp1,pp2,pp3;



always@(a or b) begin
pp0 = { (a[0]&b[3]), (a[0]&b[2]) ,(a[0]&b[1]), (a[0]&b[0]) };
pp1 =  {(a[1]&b[3]),(a[1]&b[2]), (a[1]&b[1]), (a[1]&b[0])};
pp2 = {(a[2]&b[3]),(a[2]&b[2]), (a[2]&b[1]), (a[2]&b[0])};
pp3 = {(a[3]&b[3]),(a[3]&b[2]), (a[3]&b[1]), (a[3]&b[0])};
p = (pp0) + (pp1 <<1) + (pp2<<2) + (pp3 << 3); 
end

endmodule
