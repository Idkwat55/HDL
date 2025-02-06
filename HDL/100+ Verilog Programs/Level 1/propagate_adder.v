`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////



module propagate_adder(
    input wire [3:0] a,b,
    input wire cin,
    output reg [3:0] sum,
    output reg carry
);

    // g_i  = a_i & b_i 
    // p_i  = a_i ^ b_i 
    // s_i  = p_i ^ c_i
    // c_i+1= g_i | (c_i & p_i)

    reg [2:0] i = 0 ;
    reg [3:0] g,p;
    reg [4:0] c;

    always@(a or b or cin) begin
        c = 5'b00000;
        c[0] = cin;

        for (i = 0; i<4; i = i + 1) begin
            g[i] = a[i] & b[i];
            p[i] = a[i] ^ b[i];
            sum[i] = p[i] ^ c[i];
            c[i+1] = g[i] | (c[i] & p[i]);
        end
        carry = c[4];
    end


endmodule
