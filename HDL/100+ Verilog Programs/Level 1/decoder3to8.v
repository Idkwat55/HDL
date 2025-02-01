`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////



module decoder3to8(
    input wire a,b,c,
    output wire q0,q1,q2,q3,q4,q5,q6,q7
);
    /*
    Truth Table:
    a b c | q0 q1 q2 q3 q4 q5 q6 q7
    -------------------------------
    0 0 0 |  1  0  0  0  0  0  0  0
    0 0 1 |  0  1  0  0  0  0  0  0
    0 1 0 |  0  0  1  0  0  0  0  0
    0 1 1 |  0  0  0  1  0  0  0  0
    1 0 0 |  0  0  0  0  1  0  0  0
    1 0 1 |  0  0  0  0  0  1  0  0
    1 1 0 |  0  0  0  0  0  0  1  0
    1 1 1 |  0  0  0  0  0  0  0  1
    */

    assign {q7, q6, q5, q4, q3, q2, q1, q0} = 8'b00000001 << {a,b,c};


endmodule
