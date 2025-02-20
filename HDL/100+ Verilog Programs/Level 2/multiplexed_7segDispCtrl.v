`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 20:22:06
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
    // Based on
    /*
     * Common Anode 
     */
    // Define 7-segment patterns as local parameters
    //                           h=dp
    //                              hgfedcba
    localparam [7:0] ZERO      = 8'b11000000; // 0
    localparam [7:0] ONE       = 8'b11111001; // 1
    localparam [7:0] TWO       = 8'b10100100; // 2
    localparam [7:0] THREE     = 8'b10110000; // 3
    localparam [7:0] FOUR      = 8'b10011001; // 4
    localparam [7:0] FIVE      = 8'b10010010; // 5
    localparam [7:0] SIX       = 8'b10000010; // 6
    localparam [7:0] SEVEN     = 8'b11111000; // 7
    localparam [7:0] EIGHT     = 8'b10000000; // 8
    localparam [7:0] NINE      = 8'b10010000; // 9
    localparam [7:0] DEFAULT   = 8'b11111111; // Default pattern (off)
    localparam [7:0] TEN       = 8'b11001000; // A
    localparam [7:0] ELEVEN    = 8'b10000011; // B
    localparam [7:0] TWELVE    = 8'b11000110; // C
    localparam [7:0] THIRTEEN  = 8'b11000001; // D
    localparam [7:0] FOURTEEN  = 8'b10000110; // E
    localparam [7:0] FIFTEEN   = 8'b10001110; // F   


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

    initial begin
        // Initialize all displays to off
        segDisp0 = DEFAULT;
        segDisp1 = DEFAULT;
        segDisp2 = DEFAULT;
        segDisp3 = DEFAULT;
    end

    // Default values and assignments
    always@(data or sel) begin
        // Select the active display and assign the correct pattern
        case (sel)
            2'b00: segDisp0 = getSegmentPattern(data);
            2'b01: segDisp1 = getSegmentPattern(data);
            2'b10: segDisp2 = getSegmentPattern(data);
            2'b11: segDisp3 = getSegmentPattern(data);
        endcase
    end

endmodule
