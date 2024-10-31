
module multiplexor #(
    parameter WIDTH = 5
) (
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input sel,
    output [WIDTH-1:0] mux_out
);

    // Continuous assignment using the conditional operator
    assign mux_out = sel ? in1 : in0;

endmodule