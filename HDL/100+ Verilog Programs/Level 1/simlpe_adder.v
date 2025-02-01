//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps


module simple_adder(
    input [3:0] a,b,
    input carry_in,
    output [3:0] sum,
    output carry
);

    assign {carry,sum} = a + b + carry_in;

endmodule
