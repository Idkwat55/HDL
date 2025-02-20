`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
    Shift and Add Multiplier :
    
    - Given inputs a, b of any width, you wil produce an output of width max(a_width, b_width)
    - Then you choose either a or b
    - Suppose b is chosen, we iterate over each bit of b
    - If current bit of b is 1, you add a to your product register
    - Regardless of if current bit b is 1 or 0, you shift the number you chose to iterate over to the 'right', 
        while you shift the other number to the left
            
    Note :
    This is a simple multiplier, doesn't have any mechanism to handle input changes before valid output is produced
*/
//////////////////////////////////////////////////////////////////////////////////


module SA_mult(a,b,p);
    input wire  [7:0] a, b;
    output reg [15:0]p;

    reg [15:0] a1,b1;

    reg [3:0] i;
    always @(a or b) begin

        p = {16{1'b0}};
        a1 = {8'b0000_0000,a};
        b1 = {8'b0000_0000,b};

        for (i = 0; i < 8;i = i + 1) begin

            if (b1[0]==1) begin
                p = p + a1;
                a1 = a1<<1;
                b1 = b1>>1;
            end
            else begin
                a1 = a1<<1;
                b1 = b1>>1;
            end


        end

    end

endmodule
