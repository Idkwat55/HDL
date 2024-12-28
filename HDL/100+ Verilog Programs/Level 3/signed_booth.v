`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.11.2024 20:17:43
// Design Name: 
// Module Name: signed_booth
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


module signed_booth(
input wire signed [7:0] a,b,
output reg signed [15:0] p
    );
    
    reg  signed [15:0]  Acc;
    reg signed [7:0] q,m;
   integer  count;
    reg qres;
    
    always@(a or b) begin
        Acc=0;
        qres=0;
         
        m = a;
        q= b;
            for (count = 0; count < 8; count = count+1) begin 
              
                    
               if ({q[0],qres} == 2'b01)  
                    Acc = Acc + m;
                   
             
               if  ({q[0],qres} == 2'b10)  begin
                    Acc = Acc - m;
                   
                end
                {Acc,q,qres} = {Acc,q,qres} >>> 1;
                 
            end
         p = {Acc,q};
    end
    
endmodule
