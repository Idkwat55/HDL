module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output [3:0] Q,       // Parallel Output
    output RCO            // Ripple Carry Output (Terminal Count)
);

reg [3:0] count; // Declare count as a 4-bit register

always @(posedge CLK or negedge CLR_n)
begin
    if (CLR_n == 0) begin
        count <= 4'b0000;
    end else if (LOAD_n == 0) begin
        count <= D;
    end else if (ENP == 1 && ENT == 1) begin
        count <= count + 1;
    end
end

assign Q = count;
assign RCO = (count[3] & count[2] & count[1] & count[0] & ENT);

endmodule

