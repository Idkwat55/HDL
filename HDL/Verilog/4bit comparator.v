module four_bit_comparator (
    input [3:0] A,
    input [3:0] B,
    output eq, // Output for equal (A == B)
    output lt, // Output for less than (A < B)
    output gt  // Output for greater than (A > B)
);

assign eq = (A == B);
assign lt = (A < B);
assign gt = (A > B);

endmodule
