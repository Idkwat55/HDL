`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2024 10:24:28
// Design Name: 
// Module Name: bcd_counter
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

// Counts from 00 to 99 in decimal : 0000_0000 to 1001_1001 binary

module bcd_counter(
    input wire clk, d, rst_,
    output reg [3:0] bcd0, bcd1
);

    always@(posedge clk or negedge rst_) begin
        if (!rst_) begin
            {bcd1,bcd0} <=0;
        end
        else if (d) begin
            if (bcd0 === 4'b1001) begin
                bcd0 <= 0;
                bcd1 <= bcd1 + 1;
            end else
                bcd0 <= bcd0 + 1;
            if (bcd1 === 4'b1001 && bcd0 === 4'b1001) begin
                bcd1 <= 0;
                bcd0 <= 0;
            end
        end
    end

endmodule
