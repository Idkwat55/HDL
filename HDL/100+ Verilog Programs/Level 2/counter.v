`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G
// GitHub :https://github.com/Idkwat55/HDL/tree/4fc7b4d3cff6c1bce086c2d4c9d261073b626404/HDL/100%2B%20Verilog%20Programs/Level%202
//////////////////////////////////////////////////////////////////////////////////

`default_nettype none

module counter 
(
    input wire [3:0] D, // Data to be loaded in
    input wire RST_, // Active low reset
    input wire CLK, // Clock
    input wire M, // Count mode : M - 0 -> Up, M - 1 -> Down
    input wire CE, // Clock Enable
    input wire LD, // Load Signal : If high, loads D into internal reg, and counts from that value as per M
    output reg [3:0] Q, // Actual output
    output reg CO // Carry out / Overflow / cycle complete : Indicates maximum value has been reached
);


    always@(posedge CLK or negedge RST_) begin
        if (!RST_) begin
            Q <= 4'b0000;
            CO <= 1'b0;
        end
        else if ( CE ) begin
            if (LD) begin
                Q <= D;
                CO <= 1'b0;
            end
            else if (M) begin // Down
                if (Q > 4'b0000 )
                    Q <= Q -1;
                if (Q  == 4'b0000)  
                    Q <= 4'b1111;
                    if (Q -1 == 4'b0000)
                    CO <= 1'b1;
                 
            end
            else begin // UP
                if (Q < 4'b1111)
                    Q <= Q + 1;
                 if (Q  == 4'b1111)  
                    Q <= 4'b0000;
                    if (Q + 1 == 4'b1111)
                    CO <= 1'b1;
                 
            end
        end
    end


endmodule
