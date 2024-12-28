`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 20:55:46
// Design Name: 
// Module Name: universal_shift8b
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


module universal_shift8b(
input wire sin,clk, rst_, en,
input wire [1:0] sel,
input wire [7:0] pin,
output reg  sout, 
output reg [7:0] pout
    );
    
     
    reg [7:0] r1;
    
    always@(posedge clk or negedge rst_) begin
    if (!rst_) begin
    sout <=0;
    pout <=0;
    end
    else if (en) begin
    case (sel)
    'b00: begin :No_change
    r1 <= r1;
    end
    'b01:begin: Shift_Right
    r1 <= {sin, r1[7:1]};  
    sout <= r1[0];      
 
    end
    'b10: begin :Shift_left
 r1 <= {r1[6:0], sin};  
sout <= r1[7];       
    end
    'b11: begin : parallel_load
    r1 <= pin;
    end
    default: begin
r1<= r1;
    end
    endcase
    pout <= r1;
    end
    end
    
    
endmodule
