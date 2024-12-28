`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2024 22:18:48
// Design Name: 
// Module Name: crossbar4x4
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
 

module crossbar4x4(
    input [3:0] A,            // 4 inputs
    input [15:0] ctrl,        // 16 control bits (4 per output)
    output reg [3:0] Y        // 4 outputs
);

always @(*) begin
    // Each output independently selects one input based on control signals
    Y[0] = (ctrl[1:0] == 2'b00) ? A[0] :
           (ctrl[1:0] == 2'b01) ? A[1] :
           (ctrl[1:0] == 2'b10) ? A[2] :
                                  A[3];

    Y[1] = (ctrl[3:2] == 2'b00) ? A[0] :
           (ctrl[3:2] == 2'b01) ? A[1] :
           (ctrl[3:2] == 2'b10) ? A[2] :
                                  A[3];

    Y[2] = (ctrl[5:4] == 2'b00) ? A[0] :
           (ctrl[5:4] == 2'b01) ? A[1] :
           (ctrl[5:4] == 2'b10) ? A[2] :
                                  A[3];

    Y[3] = (ctrl[7:6] == 2'b00) ? A[0] :
           (ctrl[7:6] == 2'b01) ? A[1] :
           (ctrl[7:6] == 2'b10) ? A[2] :
                                  A[3];
end

endmodule

