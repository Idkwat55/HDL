`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2024 18:35:22
// Design Name: 
// Module Name: singlePort_RAM
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

// Synchronous Single Port RAM

module singlePort_RAM(
input wire [7:0] Din, Addr,
output reg [7:0] Dout,
input CLK, EN, WE
    );
    
    // WE -> 1 = Write
    // WE -> 0 = Read

    reg [7:0] ram [255:0];

    always @(posedge CLK) begin
        if (EN) begin
            if (WE) begin
                ram[Addr] <= Din;
            end
            else if (!WE)
            Dout = ram[Addr];
            end
    end
    
endmodule
