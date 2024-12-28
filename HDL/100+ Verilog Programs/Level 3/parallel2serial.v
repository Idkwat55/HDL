`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 15:29:06
// Design Name: 
// Module Name: parallel2serial
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


module parallel2serial(
            
input wire [3:0] d,
input wire clk, rst_, sl,
output reg   so
    );
    
reg [3:0] tmp;

always@(posedge clk or negedge rst_  )  begin
if (!rst_  ) begin
so <= 0;
tmp <= 0;
end
else begin
if (sl)
tmp <= d;
else begin
so <=tmp[0];
tmp <= tmp >>1;
end
end

end
    
endmodule

