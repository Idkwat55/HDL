`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.12.2024 19:31:19
// Design Name: 
// Module Name: pulse_sync
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

// Definition of a Pulse Synchroniser is rather ambiguos. Here it is used as a 2-ff synchronizer


module pulse_sync(
input wire clk, rst_,en, in,
output wire dout
    );
    wire w1;
    dff f1 (.d(in), .clk(clk & en), .rst_(rst_), .q(w1));
    dff f2 (.d(w1), .clk(clk & en), .rst_(rst_), .q(dout));
    
    
    
endmodule


module dff(
input wire d, clk, rst_,
output reg q,qb
);
always@(posedge clk or negedge rst_) begin
if (!rst_) begin
q <= 0;
qb<= 1;
end
else begin
q <= d;
qb <= ~d;
end
end

endmodule