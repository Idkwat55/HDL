`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2024 18:54:07
// Design Name: 
// Module Name: FIFO
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


// 8 bit x 256 word

module FIFO(
    input wire clk, rst_, wen, ren,
    input wire [7:0] Din,
    output reg [7:0] Dout,
    output reg full, empty
);
    reg [7:0] i;
    reg [8:0] wptr, rptr;
    reg [7:0] mem [255:0];


    always@(posedge clk) begin

        if (!rst_) begin
            wptr <= 0;
            rptr <= 0;
            Dout <= 0;
            full <= 0;
            empty <= 1;
        end else begin

            if (wen & !full) begin
                mem[wptr] <= Din;
                wptr <= wptr + 1;
            end
            if (ren & !empty ) begin
                Dout <= mem[rptr];
                rptr <= rptr + 1;
            end

            if (rptr == wptr)
                empty = 1'b1;
            else
                empty = 1'b0;
            if ( (rptr[8] ^ wptr[8]) & ( rptr[7:0] == wptr[7:0]) )
                full = 1;
            else
                full = 0;
        end
    end



endmodule
