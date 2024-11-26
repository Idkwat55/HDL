`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2024 20:22:06
// Design Name: 
// Module Name: multiplexed_7segDispCtrl
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

module multiplexed_7segDispCtrl(
    input wire [4:0] data,
    input wire [1:0] sel,
    output reg [8:0] segDisp0, segDisp1, segDisp2, segDisp3
);

    // Define 7-segment patterns as local parameters
    localparam [8:0] ZERO  = 9'b111111000;  // 0
    localparam [8:0] ONE   = 9'b011000000;  // 1
    localparam [8:0] TWO   = 9'b110110100;  // 2
    localparam [8:0] THREE = 9'b111100100;  // 3
    localparam [8:0] FOUR  = 9'b011001100;  // 4
    localparam [8:0] FIVE  = 9'b101101100;  // 5
    localparam [8:0] SIX   = 9'b101111100;  // 6
    localparam [8:0] SEVEN = 9'b111000000;  // 7
    localparam [8:0] EIGHT = 9'b111111100;  // 8
    localparam [8:0] NINE  = 9'b111101100;  // 9
    localparam [8:0] TEN   = 9'b111011100;  // A
    localparam [8:0] ELEVEN = 9'b001111100; // B
    localparam [8:0] TWELVE = 9'b100111000; // C
    localparam [8:0] THIRTEEN = 9'b011110100; // D
    localparam [8:0] FOURTEEN = 9'b100111100; // E
    localparam [8:0] FIFTEEN = 9'b100011100; // F
    localparam [8:0] DEFAULT = 9'b000000000; // Default pattern (off)

    // Function to map `data` to the appropriate segment pattern
    function [8:0] getSegmentPattern(input [4:0] data);
        case (data)
            5'd0: getSegmentPattern = ZERO;
            5'd1: getSegmentPattern = ONE;
            5'd2: getSegmentPattern = TWO;
            5'd3: getSegmentPattern = THREE;
            5'd4: getSegmentPattern = FOUR;
            5'd5: getSegmentPattern = FIVE;
            5'd6: getSegmentPattern = SIX;
            5'd7: getSegmentPattern = SEVEN;
            5'd8: getSegmentPattern = EIGHT;
            5'd9: getSegmentPattern = NINE;
            5'd10: getSegmentPattern = TEN;
            5'd11: getSegmentPattern = ELEVEN;
            5'd12: getSegmentPattern = TWELVE;
            5'd13: getSegmentPattern = THIRTEEN;
            5'd14: getSegmentPattern = FOURTEEN;
            5'd15: getSegmentPattern = FIFTEEN;
            default: getSegmentPattern = DEFAULT;
        endcase
    endfunction

    // Default values and assignments
    always @(*) begin
        // Initialize all displays to off
        segDisp0 = DEFAULT;
        segDisp1 = DEFAULT;
        segDisp2 = DEFAULT;
        segDisp3 = DEFAULT;

        // Select the active display and assign the correct pattern
        case (sel)
            2'b00: segDisp0 = getSegmentPattern(data);
            2'b01: segDisp1 = getSegmentPattern(data);
            2'b10: segDisp2 = getSegmentPattern(data);
            2'b11: segDisp3 = getSegmentPattern(data);
        endcase
    end

endmodule
