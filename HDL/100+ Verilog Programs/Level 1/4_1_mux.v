//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

module mux4to1 (
    output y,
    input [1:0] sel,
    input a,b,c,d
);

    assign y =  ( sel == 2'b00 ) ? a
    : ( sel == 2'b01 ) ? b
    : ( sel == 2'b10 ) ? c
    : ( sel == 2'b11 ) ? d
    : 1'bx;

endmodule 