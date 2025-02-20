`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
    Ring Counter :

    - A bunch of flip flops in a chain, what output of last flip flop is input to the first one
    - The one here is sort of the opposite, shouldn't matter, as concept is same as this is for educational purposes
*/
//////////////////////////////////////////////////////////////////////////////////


module ring_counter(
    input wire clk, rst_,
    output reg  [3:0] q
);

    always@(posedge clk or negedge rst_) begin
        if (!rst_)
            q <= 4'b1000;
        else begin
            q[3] <= q[2] ;
            q[2] <= q[1];
            q[1] <= q[0];
            q[0] <= q[3];
        end
    end

endmodule

 
