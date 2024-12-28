`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 16:45:14
// Design Name: 
// Module Name: parityChecker8bit
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


module parityChecker8bit(
input wire [7:0] A, 
input Pin, O_E, // Pin - Parity bit ,  O_E, odd - 0, even - 1
output reg match ,mismatch
    );
    reg Pgen;
    always @(A or  O_E  or Pin) begin
        Pgen = ^A;
        if (O_E) begin
        if (Pin == Pgen) begin
        match = 1'b1;
        mismatch = 1'b0;
        end
        else begin
        mismatch = 1'b1;
        match = 1'b0;
        end
        end else begin
        if ( Pin == ~Pgen) begin
        match = 1'b1;
        mismatch = 1'b0;
        end
        else begin
        mismatch = 1'b1;
        match = 1'b0;
        end     
        end
    end

endmodule
