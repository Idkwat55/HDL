`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2024 13:18:09
// Design Name: 
// Module Name: ArithmeticShifter_8b
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


//basic ASR, ASL
// parallel input parallel output

// rl -> left/right, r for 1, l  - 0

module ArithmeticShifter_8b(
input wire[7:0] d,
input wire clk, rst_,ce,rl,
output reg [7:0] dout
    );
    
    reg [7:0] tmp;
    reg sign;
    always@(posedge clk or negedge rst_)begin
    if (!rst_) 
    dout <=0;
    else begin
    tmp<=d;
    sign <= d[7];
    if (rl) begin
    tmp <= tmp  >> 1;
    end
    else 
    tmp<= tmp << 1;
    tmp[7]<= sign;
    dout <= tmp;
    end
    end
    
endmodule
