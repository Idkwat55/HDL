`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 14:35:16
// Design Name: 
// Module Name: incrementor4b
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

// 4 bit incrementor / up - counter

module incrementor4b(
input d, clk,rst_,
output reg [3:0] count
    );
    
    always@(posedge clk or negedge rst_) begin
    if (!rst_) 
    count = 4'b0000;
    else if (d)
    count = count + 1;
    
    end
    
endmodule
