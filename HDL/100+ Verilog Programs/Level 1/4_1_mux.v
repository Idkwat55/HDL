module mux4to1 (
output y,
input [1:0] sel,
input a,b,c,d                 
);

assign y = sel == 2'b00 ? a : sel == 2'b01 ? b : sel == 2'b10 ? c : sel == 2'b11 ? d : 1'bx;

endmodule 