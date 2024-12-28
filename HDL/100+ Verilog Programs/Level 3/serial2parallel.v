`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 15:21:30
// Design Name: 
// Module Name: serial2parallel
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


module serial2parallel(
 
input wire  d,
input wire clk, rst_, sl,
output reg [3:0] so
    );
    
reg [3:0] tmp;

always@(posedge clk or negedge rst_ )  begin
if (!rst_  ) begin
so <= 0;
tmp<= 0;
end
else begin
if (sl) begin
tmp <= tmp >>1;
tmp[3] <= d;

end
else begin
tmp <= tmp >>1;
so <= tmp;
end
end
end
    
endmodule

