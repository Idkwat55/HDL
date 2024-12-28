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
    reg [16:0] counter;    
    reg [63:0] counter2;    
    
     
    // 10 MHz => 10 ns period, takes 40.96 us to count 2^12 (4096)  or 2**16 (65536) cycles
    
    
    // freq = counter2 / (4096 * ref_clk_period)  
    
    always @(posedge ref_clk) begin
        if (!rst_) begin
            counter <= 0;
            freq <= 0;  // Reset frequency on reset
        end else if (en) begin
            if (counter == 65536) begin
              
                freq <= (counter2 * 10000000) / 65536;
                counter <= 0;  
                counter2 <= 0;  
            end else begin
                counter <= counter + 1;  
            end
        end
    end
    
    always @(posedge targ_clk) begin
        if (!rst_) begin
            counter2 <= 0;
        end else if (en) begin
            counter2 <= counter2 + 1; // Increment target clock counter
        end
    end

endmodule
