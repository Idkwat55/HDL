`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2024 10:53:05
// Design Name: 
// Module Name: grayCode_counter
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


module grayCode_counter(
    input wire clk,d,rst_,
    output reg [3:0] count
);

    reg [3:0] bin_count = 0;

    always@(posedge clk or negedge rst_) begin
        if(!rst_) begin
            count <= 0;
            bin_count <= 1;
        end
        else begin
            bin_count <= bin_count + 1;
            count <= bin_count ^ ( bin_count >> 1);
        end
    end

endmodule
