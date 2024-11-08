module mux2to1(
output y,
input a,b,sel
);

  // sel = 0, y = a, or if sel = 1, y=b
 
assign y = (sel == 1'b0) ? a : (sel == 1'b1) ? b : 1'bx;

endmodule