module nand_ (
output c,
input a,b
);

assign c =~( a & b);
endmodule