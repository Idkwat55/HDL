`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////


module comp4b(
    input [3:0] a,b,
    output gt,lt,eq
);


    assign gt = (a>b) ? 1 : 1'bz;
    assign lt = (a<b) ? 1 : 1'bz;
    assign eq = (a==b) ? 1 : 1'bz;

endmodule
