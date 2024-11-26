`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2024 17:55:49
// Design Name: 
// Module Name: 4b_counter
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
`default_nettype none

module counter_4b(
input wire [3:0] D,
input wire RST_, CLK, M, CE, LD,
output reg [3:0] Q,
output reg CO
);

    
    always@(posedge CLK or negedge RST_) begin
        if (!RST_) begin
            Q <= 4'b0000;
            CO <= 1'b0;
        end
        else if ( CE === 1'b1) begin
            if (M) begin // Down
                if (LD) begin
                    Q <= D;
                    CO <= 1'b0;
                end 
                else if (Q > 4'b0000 ) 
                    Q <= Q -1;
                    else begin 
                        Q <= 4'b1111;
                        CO <= 1'b1;
                    end
            end 
            else begin // UP
                if (LD) begin
                    Q <= D;
                    CO <= 1'b0;
                end 
                else if (Q < 4'b1111) 
                    Q <= Q + 1;
                    else begin
                        Q <= 4'b0000;
                        CO <= 1'b1;
                    end
            end
        end
    end  
    
    
endmodule
