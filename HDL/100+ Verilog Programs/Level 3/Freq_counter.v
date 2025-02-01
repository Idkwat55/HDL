`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.12.2024 20:46:06
// Design Name: 
// Module Name: Freq_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Frequency counter based on reference and target clocks
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Freq_counter(
    input wire ref_clk, targ_clk, en, rst_,
    output reg [31:0] freq
);
    reg [16:0] counter;    // Counts cycles of the reference clock (max 65536)
    reg [63:0] counter2;   // Counts cycles of the target clock
    
    // Assumption: ref_clk frequency = 10 MHz (10 ns period)
    // freq = counter2 / (65536 * ref_clk_period)
    // => freq = (counter2 * 10^7) / 65536 (in Hz)

    always @(posedge ref_clk) begin
        if (!rst_) begin
            counter <= 0;
            freq <= 0;      // Reset frequency on reset
            counter2 <= 0;  // Reset target clock counter
        end else if (en) begin
            if (counter == 65536 - 1) begin  // 65536 reference clock cycles
                freq <= (counter2 * 10000000) / 65536;  // Calculate frequency in Hz
                counter <= 0;  // Reset reference clock counter
                counter2 <= 0; // Reset target clock counter
            end else begin
                counter <= counter + 1;  // Increment reference clock counter
            end
        end
    end
    
    always @(posedge targ_clk) begin
        if (en) begin
            counter2 <= counter2 + 1;  // Increment target clock counter
        end
    end
endmodule
