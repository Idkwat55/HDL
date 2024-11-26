`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2024 17:31:12
// Design Name: 
// Module Name: traffic_controller
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

//4 way intersection, North, south, east, west
// 10Mhz clock, 10ns each cycle. 1 second - 10 * (10 ** 6) cycles -> 10,000,000
//For practice, 500kHz, 20us. 500,000 cycles.

module traffic_controller(
input wire clk, rst_, en, ld, 
input wire [3:0] data,
output reg [2:0]  north_south, east_west
    );
    
    localparam green= 3'b100;
    localparam yellow= 3'b010;
    localparam red = 3'b001; 
    localparam off = 3'b000;
//        State	North-South	East-West
//    1	Green	Red
//    2	Yellow	Red
//    3	Red	    Green
//    4	Red	    Yellow
//    5	Green	Yellow
//    6	Yellow	Green
//    7	Red	Red (All Red)
//    8	Green	Green (Rare, emergency)
//    9	Yellow	Yellow (Rare, caution mode)

    reg [3:0] curStat;
    reg [23:0] counter2;
    reg [5:0] counter;
    reg en1;
    
    // Data load block
    always @(posedge clk or negedge rst_) begin
        if (!rst_) begin
            en1 <= 0;
            curStat <= 4'b0110; // All Red (state 6)
            north_south <= red;
            east_west <= red;
            counter <= 0;
            counter2 <=0;
        end else if (ld) begin
            en1 <= 0;          // Disable enable signal during load
            curStat <= data;   // Load new state
        end else begin
            en1 <= en;         // Enable based on input
        end
    end
    
    // State machine
    always @(posedge clk or negedge rst_) begin
        if (!rst_) begin
            curStat <= 4'b0110; // Reset to All Red
            north_south <= red;
            east_west <= red;
            counter <= 0;
            counter2 <=0;
        end else if (en1) begin
            case (curStat)
                4'b0000: begin // State 1: North-South Green, East-West Red
                    north_south <= green;
                    east_west <= red;
                    if (counter2 >= 'd500000)begin
                        counter2<= 'd0;
                        counter <= counter + 1;
                    end
                    else
                        counter2 <= counter2 + 1;
                    if (counter == 'd50) begin
                        curStat <= 4'b0001;
                    end
                    
                end
                4'b0001: begin // State 2: North-South Yellow, East-West Red
                    
                    east_west <= red;
                    if (counter2 >= 'd500000)begin
                        north_south <= (north_south == off ) ? yellow : off;
                        counter2<= 'd0;
                        counter <= counter + 1;
                    end
                    else
                        counter2 <= counter2 + 1;
                    if (counter >= 'd60) begin
                        curStat <= 4'b0010;
                        counter<= 'd0;
                    end
                    
                    
                end
                4'b0010: begin // State 3: North-South Red, East-West Green
                    north_south <= red;
                    east_west <= green;
                    if (counter2 >= 'd500000)begin
                        counter2<= 'd0;
                        counter <= counter + 1;
                    end
                    else
                        counter2 <= counter2 + 1;
                    if (counter == 'd50) begin
                        curStat <= 4'b0011;
                    end
                     
                   
                end
                4'b0011: begin // State 4: North-South Red, East-West Yellow
                    north_south <= red;
                    
                    if (counter2 >= 'd500000)begin
                        east_west <= (north_south == off ) ? yellow : off;
                        counter2<= 'd0;
                        counter <= counter + 1;
                    end 
                    else
                        counter2 <= counter2 + 1;
                    if (counter == 'd60) begin
                        curStat <= 4'b0000;
                        counter <= 'd0;
                    end
                   
                    
                end
                4'b0100: begin // State 5: North-South Green, East-West Yellow
                    north_south <= green;
                    east_west <= yellow;
                    curStat<=data;
                end
                4'b0101: begin // State 6: North-South Yellow, East-West Green
                    north_south <= yellow;
                    east_west <= green;
                    curStat<=data;
                end
                4'b0110: begin // State 7: All Red
                    north_south <= red;
                    east_west <= red;
                    counter <= 0;
                    counter2 <=0;
                    curStat<='b0000;
                end
                4'b0111: begin // State 8: All Green
                    north_south <= green;
                    east_west <= green;
                    curStat<=data;
                end
                4'b1000: begin // State 9: All Yellow
                    north_south <= yellow;
                    east_west <= yellow;
                    curStat<=data;
                end
                default: begin // Default: Reset to state 1
                    north_south <= red;
                    east_west <= red;
                    counter <= 0;
                    counter2 <=0;
                    curStat <= 4'b0000;
                end
            endcase
        end
    end
    
endmodule
