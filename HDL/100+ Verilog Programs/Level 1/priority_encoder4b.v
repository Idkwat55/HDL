`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 14:35:16
// Design Name: 
// Module Name: priority_encoder4b
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

//4 to 2 

module priority_encoder4b(
input a,b,c,d,
output q1,q0
    );
    
assign {q1,q0} = ({a,b,c,d} == 4'b0001 ) ? 2'b00 : 1'bx;
assign {q1,q0} = ({a,b,c,d} == 4'b001x ) ? 2'b01 : 1'bx;
assign {q1,q0} = ({a,b,c,d} == 4'b01xx ) ? 2'b10 : 1'bx;
assign {q1,q0} = ({a,b,c,d} == 4'b1xxx ) ? 2'b11 : 1'bx;

    
endmodule
