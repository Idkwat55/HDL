`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2024 15:05:12
// Design Name: 
// Module Name: stopwatch
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

// clk - 100Mhz
//  10 ns per clock cycle. 
// d100_000_000

module stopwatch(
input wire start, stop, reset, clk,
output reg [3:0] s0, s1, m0,m1 
    );

    reg flg;
    reg [27:0] counter;

    always @(posedge clk ) begin
        if (reset) begin
            counter <= 0;
            flg <= 0;
            s0 <= 0;
            s1 <= 0;
            m0 <= 0;
            m1 <= 0;
        end else begin
            if (start & !stop)
            flg <= 1;
            else if (stop & !start)
            flg <= 0;
            if (flg) begin
            counter <= counter + 1;
            if (counter == 'd100_000_000) begin
            counter <= 0;
            s0 <= s0 + 1;
            if (s0 == 4'b1001) begin
                s0 <= 0;
                s1 <= s1 + 1;
                if ((s1 + 1) == 4'b0110 ) begin
                s1 <= 0;
                m0 <= m0 + 1;
                if ( m0 == 4'b1001 ) begin
                m0 <= 0;
                m1 <= m1 + 1;
                if ( m1 == 4'b1001) begin
                flg <= 0;
                
                end
                end
                end
                end
            end
            end
        end
    end

endmodule
