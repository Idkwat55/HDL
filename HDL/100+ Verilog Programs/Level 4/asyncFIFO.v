`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 18:21:35
// Design Name: 
// Module Name: asyncFIFO
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


module asyncFIFO(
    input wire wclk, rclk, rst_, wen, ren,
    input wire [7:0] Din,
    output reg [7:0] Dout,
    output reg full, empty
);

    reg [7:0] mem [255:0] ;
    reg [7:0] wptr, rptr;

    always @(posedge wclk or rst_) begin
        if (!rst_) begin
            wptr <= 0;
            full <= 0;
        end else begin
            if (wen & !full) begin
                mem[wptr] <= Din;
                wptr <= wptr + 1;
                if (wptr == (rptr - 1) )
                    full <= 1;
                else
                    full <= 0;
            end
        end
    end

    always @(posedge rclk) begin
        if (!rst_) begin
            rptr <= 0;
            empty <= 1;
            Dout <= 0;
        end else begin
            if (ren & !empty) begin
                Dout <= mem[rptr];
                rptr <= rptr + 1;
                empty <= (wptr == rptr);
            end
        end
    end


endmodule
