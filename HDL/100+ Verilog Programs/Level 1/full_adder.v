`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////



module full_adder(
    input a,b,c,
    output sum, carry
);
    assign sum = a ^ b ^ c;
    assign carry = (a & b) | ( (a^b) & c );
endmodule
