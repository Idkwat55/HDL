`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 14:35:16
// Design Name: 
// Module Name: priority_encoder4b
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

//4 to 2 

module priority_encoder4b(
    input wire a, b, c, d,
    output reg q1, q0
    );

    always @(*) begin
        casez ({a, b, c, d}) // Use casez for wildcard matching
            4'b1???: {q1, q0} = 2'b11; // 'a' has the highest priority
            4'b01??: {q1, q0} = 2'b10; // 'b' has the next priority
            4'b001?: {q1, q0} = 2'b01; // 'c' has the next priority
            4'b0001: {q1, q0} = 2'b00; // 'd' has the lowest priority
            default: {q1, q0} = 2'b00; // Default value
        endcase
    end
endmodule
