`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2024 12:14:51
// Design Name: 
// Module Name: PIPO
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

 
// sl - shift / load : if load (1) , d is allowed to interact with reg, else if shift (0) input doesnt get to reg, if there is a tmp reg, its content is read.


// sl is not useful for pipo. PIPO is more of a buffer.

module PIPO(
input wire [3:0] d,
input wire clk, rst_,   
output reg [3:0] so
    );
    

always@(posedge clk or negedge rst_  )  begin
if (!rst_  ) begin
so <= 0;
end
else begin

so <= d;
end
end
    
endmodule
