`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 18:04:01
// Design Name: 
// Module Name: LFSR
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


module LFSR(
input wire clk, rst_,ld,
input wire [7:0] data,
output wire [7:0] PRN, PRN1
    );
     
 
    dff ff_0 (.d((rst_ == 1) ? ((ld == 1 )? (data[0] & ld) : PRN[1] ^ PRN[2] ^ PRN[3] ^  PRN[4] ^ PRN[5] ^ PRN[6] ^ PRN[7] ): 'b0), .clk(clk), .rst_(rst_), .q(PRN[0]), .qb(PRN1[0]));
    dff ff_1 (.d((rst_ == 1) ? ((ld == 1 )? (data[1] & ld) : PRN[0] ): 'b0), .clk(clk), .rst_(rst_), .q(PRN[1]), .qb(PRN1[1]));
    dff ff_2 (.d((rst_ == 1) ? ((ld == 1 )? (data[2] & ld) : PRN[1] ): 'b0), .clk(clk), .rst_(rst_), .q(PRN[2]), .qb(PRN1[2]));
    dff ff_3 (.d((rst_ == 1) ? ((ld == 1 )? (data[3] & ld) : PRN[2]): 'b0), .clk(clk), .rst_(rst_), .q(PRN[3]), .qb(PRN1[3]));
    dff ff_4 (.d((rst_ == 1) ? ((ld == 1 )? (data[4] & ld) : PRN[3]): 'b0), .clk(clk), .rst_(rst_), .q(PRN[4]), .qb(PRN1[4]));
    dff ff_5 (.d((rst_ == 1) ? ((ld == 1 )? (data[5] & ld) : PRN[4]): 'b0), .clk(clk), .rst_(rst_), .q(PRN[5]), .qb(PRN1[5]));
    dff ff_6 (.d((rst_ == 1) ? ((ld == 1 )? (data[6] & ld) : PRN[5] ): 'b0), .clk(clk), .rst_(rst_), .q(PRN[6]), .qb(PRN1[6]));
    dff ff_7 (.d((rst_ == 1) ? ((ld == 1 )? (data[7] & ld) :  PRN[6] ): 'b0), .clk(clk), .rst_(rst_), .q(PRN[7]), .qb(PRN1[7]));
    
 
    
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