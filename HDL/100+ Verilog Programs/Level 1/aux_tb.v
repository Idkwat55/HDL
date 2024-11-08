`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.11.2024 15:28:20
// Design Name: 
// Module Name: aux_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module propagate_adder_tb;

    // Testbench signals
    reg [3:0] a, b;        // 4-bit inputs
    reg cin;               // Carry-in
    wire [3:0] sum;        // 4-bit sum output
    wire carry;            // Carry-out

    // Instantiate the propagate_adder (Unit Under Test)
    propagate_adder uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry(carry)
    );

    // Test procedure
    initial begin
        // Display header for readability
        $display("Time\t a\t  b\tcin\t sum\tcarry");
        $display("--------------------------------------------------");

        // Apply various test cases
        a = 4'b0000; b = 4'b0000; cin = 1'b0; #10;
        $display("%g\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, sum, carry);

        a = 4'b0001; b = 4'b0010; cin = 1'b0; #10;
        $display("%g\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, sum, carry);

        a = 4'b0101; b = 4'b0011; cin = 1'b1; #10;
        $display("%g\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, sum, carry);

        a = 4'b1111; b = 4'b0001; cin = 1'b0; #10;
        $display("%g\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, sum, carry);

        a = 4'b1111; b = 4'b1111; cin = 1'b1; #10;
        $display("%g\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, sum, carry);

        a = 4'b1010; b = 4'b0101; cin = 1'b0; #10;
        $display("%g\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, sum, carry);

        a = 4'b1010; b = 4'b0101; cin = 1'b1; #10;
        $display("%g\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, sum, carry);

        // Finish simulation
        $finish;
    end

endmodule
