//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

module mux2to1(
  output y,
  input a,b,sel
);

  // sel = 0, y = a, or if sel = 1, y=b

  assign y = (sel == 1'b0) ? a : (sel == 1'b1) ? b : 1'bx;

endmodule