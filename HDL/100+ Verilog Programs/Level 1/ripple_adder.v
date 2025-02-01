//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

//Ripple carry Adders - RCA - uses full adders in a sequential order

module ripple_adder(
    input [3:0] a,b,
    input cin,
    output [3:0] sum,
    output carry
);

    wire w1,w2,w3;

    full_adder fa1 (a[0] , b[0], cin , sum[0] ,w1 );
    full_adder fa2 (a[1] , b[1], w1 , sum[1] ,w2 );
    full_adder fa3 (a[2] , b[2], w2 , sum[2] ,w3 );
    full_adder fa4 (a[3] , b[3], w3 , sum[3] ,carry );

endmodule
