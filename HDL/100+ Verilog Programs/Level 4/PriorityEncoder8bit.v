`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 16:12:02
// Design Name: 
// Module Name: PriorityEncoder8bit
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


module PriorityEncoder8bit(
input [7:0] A,
output reg [2:0] Y
    );
// dv
always @(A) begin
    casez (A)
        'b0000_0001: Y = 'b000; 
        'b0000_001?: Y = 'b001; 
        'b0000_01??: Y = 'b010; 
        'b0000_1???: Y = 'b011; 
        'b0001_????: Y = 'b100; 
        'b001?_????: Y = 'b101; 
        'b01??_????: Y = 'b110; 
        'b1???_????: Y = 'b111; 

        default: 
        Y = 'bzzz;
    endcase
end

endmodule
