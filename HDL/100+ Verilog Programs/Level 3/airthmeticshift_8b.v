`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 16:50:16
// Design Name: 
// Module Name: airthmeticshift_8b
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
    // LSR, LSL, ASR, ASR, RR, RL 

module airthmeticshift_8b(
input wire [7:0] din,
input wire [2:0] mode,
input wire  clk, rst_,
output reg [7:0] dout
    );
  
    always@(posedge clk or negedge rst_) begin
        if (!rst_) begin
            dout <= 0;
        end
        else begin
            case (mode)
                'b000: dout<= din[7:1];
                'b001: dout<= din << 1;
                'b010: begin
                  
                    dout <= {din[7],din[7:1]}; 
                end
                'b011: begin
                     
                    dout <= {din[7], (din << 1)};
                end
                'b100: begin
                     
                    dout <= {din[0],(din>>1)}; 
                end
                'b101: begin
                    
                    dout <= {(din>>1),din[7]}; 
                end
                default:
                    dout <= din;
            endcase
        end
    end
    
endmodule
