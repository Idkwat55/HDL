`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2024 12:14:51
// Design Name: 
// Module Name: PISO
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


module PISO(
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
