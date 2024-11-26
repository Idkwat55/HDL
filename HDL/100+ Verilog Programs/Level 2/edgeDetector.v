`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2024 21:42:42
// Design Name: 
// Module Name: edgeDetector
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


module edgeDetector(
input wire din, clk, rst_,
output reg [1:0] dout
    );
    
    reg tmp;
    
    always@(posedge clk or negedge rst_) begin
    if (!rst_) begin
    dout <= 0;
    tmp <=0;
    end 
    else begin
    if (tmp > din) // 10
    dout <= 'b10;
    else if (tmp<din)
    dout <= 'b01;
    else if (tmp & din )
    dout <= 'b11;
    else
    dout <='b00;
    tmp <= din;
    end
    end
    
endmodule
