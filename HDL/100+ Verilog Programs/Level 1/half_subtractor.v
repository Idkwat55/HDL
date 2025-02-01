//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module half_subtractor(
    input a,
    input b,
    output difference,
    output borrow
);
    assign difference = a ^ b; // XOR for difference
    assign borrow = ~a & b; // AND and NOT for borrow
endmodule

