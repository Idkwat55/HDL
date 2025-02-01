`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////



module decoder2to4(
    input a,b,
    output q0,q1,q2,q3
);
    /*
     * Truth Table:
     *  Input  | Output
     *   a  b  | q3 q2 q1 q0
     *  -------|------------
     *   0  0  |  0  0  0  1
     *   0  1  |  0  0  1  0
     *   1  0  |  0  1  0  0
     *   1  1  |  1  0  0  0
     */

    assign {q3,q2,q1,q0}  = 4'b001 << {a,b};


endmodule
