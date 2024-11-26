`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2024 21:39:30
// Design Name: 
// Module Name: clock_divider
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

// Power of 2 clock divider, 2, 4, 8 ,16, 32, 64, 128 , 256


module clock_divider(
input wire clk, en, rst_,
input wire [2:0] div,
output reg clk_out
    );
    
reg  [7:0] counter, tar_clk;
 
   
   function [7:0] clockVal (input [2:0] div) ;
   case (div)
   'd0: clockVal = 'd1;
   'd1: clockVal = 'd3;
   'd2: clockVal = 'd7;
   'd3: clockVal = 'd15;
   'd4: clockVal = 'd31;
   'd5: clockVal = 'd63;
   'd6: clockVal = 'd127;
   'd7: clockVal = 'd255;
   default: clockVal ='d1;
   endcase
   endfunction
    
    always@(posedge clk or negedge rst_ )begin
        if (!rst_) begin
            clk_out <= 0;
            counter <= 0;
            tar_clk <= 0;
        end
        if (en) begin    
            tar_clk <= clockVal(div);
            if (counter == tar_clk) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end
            else
            counter <= counter+1; 
        end
    end
    
endmodule
