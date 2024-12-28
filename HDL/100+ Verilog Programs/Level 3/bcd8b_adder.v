`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 16:09:22
// Design Name: 
// Module Name: bcd8b_adder
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


module bcd8b_adder(
input wire [3:0] a0,a1, b0, b1,
output reg [3:0] sum00, sum01,sum02 , 
output reg invalid
);

reg  [5:0] sum0, sum1,sum2;
reg [5:0] c,c1;

always@(a0 
    or b0 
    or a1 
    or b1) begin

    {sum0,sum1,sum2,c,c1} = 'b0;
    
    if ((a0 > 'b1001) | (a1 > 'b1001) | (b0 > 'b1001) | (b1 > 'b1001))
        invalid <= 1;
    else begin
        invalid <= 0;
        sum0 = a0 + b0;
    if (sum0 >'b1001) begin
        c = sum0 + 6;
        sum0 = c[3:0];
    end
        sum00 = sum0;
        sum1 = a1 + b1 + c[5:4];
    if (sum1 > 'b1001) begin
        c1  = sum1 + 6;
        sum1 = c1[3:0];
    end
        sum01 = sum1;
        sum2 = c1[5:4];
        sum02 = sum2;
    end 
end

endmodule
