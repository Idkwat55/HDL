`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2024 14:37:57
// Design Name: 
// Module Name: SA_mult
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


module SA_mult(a,b,p);
input wire  [7:0] a, b;
output reg [15:0]p;

reg [15:0] a1,b1; 

integer i;
always @(*) begin
p = {15'b0,0};
a1 = {15'b0,a};
b1 = b;

for (i = 0; i<7;i = i +1) begin

if (b1[0]==1) begin
p = p + a1;
a1 = a1<<1;
b1 = b1>>1;
end
else begin
a1 = a1<<1;
b1 = b1>>1;
end

end

end 

endmodule
