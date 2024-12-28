`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: -
// Engineer: Risikesvar G
// 
// Create Date: 13.12.2024 18:12:19
// Design Name: Binary GCD Calculator
// Module Name: gcd
// Project Name: Level 3 Programs
// Target Devices: -
// Tool Versions: -
// Description: -
// 
// Dependencies: -
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Assumptions :
// This code assumes inputs are always positive
// Depending on the input, calculation during is varied. It is resposibility of user to monitor the 'busy' signal and correctly capture outputs and update inputs. If not, the module will re-calculate gcd. 

// Operating Logic :
//    If U and V are both even, then gcd(U,V) = 2 * gcd(U/2,V/2)
//    If U is even and V is odd, then gcd(U,V) = gcd(U/2,V)
//    If U is odd and V is even, then gcd(U,V) = gcd(U,V/2)
//    If U and V are both odd, then gcd(U,V) = gcd((|U-V|)/2,min(U,V))


module gcd #(parameter width = 7) (
input wire [width-1:0] ia,ib, 
input wire clk, rst_, 
output reg busy,
output reg [width-1: 0] gcd
    );
    
    // Some essential registers
    reg [width-1:0] a,b,tmp, mult;
    // a flag to prevent recalculation
    reg flg;
    // a variable to indicate current states of a FSM (FSM is used as loops aren't feasible)
    reg [1:0] state;
 
    // FSM states
    localparam init = 2'b00; 
    localparam gcd_s = 2'b01;
    localparam stop = 2'b11;
    
    always@(posedge clk or negedge rst_) begin : always_block
    
         if (!rst_) begin : reset_block
             state <= init;
             gcd <= 0; 
             a <= ia;
             b <= ib;
             mult <= 0;
             busy <= 0;
             tmp <= 0;
         end
         
         else begin : reset_released // Main Blcok
         
         case (state)  
         
         init : begin : Initialization 
         a <= ia;
         b <= ib;
         mult <= 0;
         busy <= 0;
         tmp <= 0;
         if (flg) begin : while_inputs_changed_DoCalc
         busy <= 1;
         state <= gcd_s;
         end
         end
         
         gcd_s : begin : Main_calc_block
         if ( (a == b) ||  (a == 0) || ( b == 0 )  || ( ((a == 1) || (b == 1) ) && ( (a[0] != 0) || ( b[0] != 0) ) )  ) begin // Check if possible end conditions
             if (( ((a == 1) || (b == 1) ) && ( (a[0] != 0) || ( b[0] != 0) ) )) begin // This specific end condition is possible while initially
                tmp <= 1 << mult;                                                      // it may not be the case but can become possible due to the following if-else blocks. Then, raise 2^x by 1 << x
             end
             else
                tmp <= (a > b) ? a : b;  // if the specific condition ( == 1) wasn't the end condition, assign highest value as output
             state <= stop;
         end
         else if ( (a[0] == 0 ) && ( b[0] == 0 ) ) begin : both_even
             mult <= mult + 1;
             a <= a >> 1;
             b <= b >> 1;
             state <= gcd_s;
         end
         else if ((a[0] == 0 ) && ( b[0] != 0 )) begin : even_odd
             a <= a >> 1;
             state <= gcd_s;
         end
         else if ((a[0] != 0 ) && ( b[0] == 0 )) begin : odd_even
             b <= b >> 1;
             state <= gcd_s;
         end
         else if ((a[0] != 0 ) && ( b[0] != 0 )) begin : odd_odd
             a <= (a > b) ? ((a - b) >> 1) :((b - a) >> 1) ; // find absolute difference and assign half its value to a
             b <= ( a > b) ? b : a;  // assign smaller value to b
             state <= gcd_s;
         end
         end
         
         stop: begin : update_outputs
             gcd <= tmp;
             busy <= 0; 
             flg <= 0;
             state <= init;
         end
         endcase
         end
    end
    
    always@(ia or ib) begin : handle_input_change
        if (!rst_)
            flg <= 0;
        else 
            flg <= 1;
    end
    
endmodule
