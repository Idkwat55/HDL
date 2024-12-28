`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2024 21:38:30
// Design Name: 
// Module Name: LIFO
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


module LIFO(
input wire clk, rst_, wen, ren,
input wire [7:0] Din,
output reg [7:0] Dout, 
output reg full, empty
    );
    
    reg [7:0] ptr;
    reg [7:0] mem [255:0];

    always@(posedge clk) begin
        if (!rst_) begin
        ptr <= 1;
        Dout <= 0;
        empty <= 1;
        full <= 0;
        end else begin
        if (wen & !full) begin
        mem[ptr] <= Din;
        ptr <= ptr + 1;
        end
        else if (ren & !empty) begin
        ptr <= ptr - 1;
        Dout <= mem[ptr];
        end
        if ( ptr == 255 ) 
        full = 1;
        else
        full = 0;
        if (ptr == 8'b0)
        empty = 1;
        else
        empty = 0;
        end
    end
    
endmodule
