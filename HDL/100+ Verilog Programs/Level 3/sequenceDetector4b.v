`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 14:28:17
// Design Name: 
// Module Name: sequenceDetector4b
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


// detect the seqeunce 1001

module sequenceDetector4b (
    input wire clk, rst_, d, en,
    output reg detected, 
    output reg [3:0] completion
);
     
    reg [3:0] state; 

    
    always @(posedge clk or negedge rst_) begin
        if (!rst_) begin
            
            state =  4'b0000;
            detected =  0;
            completion =  4'b0000;
        end else if (en) begin
            
            state =  {state[2:0], d};

           
            case (state)
                4'b0000: begin
                    completion =  4'b0000; 
                end
                4'b0001: begin
                    completion =  4'b0001; 
                    detected =  0;
                end
                4'b0010: begin
                    completion =  4'b0011;  
                    detected =  0;
                end
                4'b0100: begin
                    completion =  4'b0111; 
                    detected =  0;
                end
                4'b1001: begin
                    completion =  4'b1111;  
                    detected = 1;  
                end
                default: begin
                    completion =  4'b0000;  
                    detected =  0;
                end
            endcase
        end
    end
endmodule
