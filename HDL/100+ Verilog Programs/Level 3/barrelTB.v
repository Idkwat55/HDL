`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.11.2024 16:57:42
// Design Name: 
// Module Name: barrelTB
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


module barrelTB;
    // Testbench signals
    reg [15:0] a;
    reg k0, k1, left;
    wire [15:0] y;
    reg [15:0] expected_y;

    // Instantiate the barrel shifter module
    barrelShifter uut (
        .a(a),
        .k0(k0),
        .k1(k1),
        .left(left),
        .y(y)
    );

    // Test procedure
    initial begin
        // Initialize the input
        a = 16'b1010_1100_1111_0001; // Example input
        $display("Initial input: %b", a);

        // Test all cases
        test_shift(0, 0, 1, 16'b0101_1001_1110_0011); // Left shift by 1
        test_shift(0, 1, 1, 16'b1011_0011_1100_0110); // Left shift by 2
        test_shift(1, 0, 1, 16'b1100_1110_0011_1001); // Left shift by 4
        test_shift(1, 1, 1, 16'b1110_0011_1001_1010); // Left shift by 8
        test_shift(0, 0, 0, 16'b1101_0110_0111_1000); // Right shift by 1
        test_shift(0, 1, 0, 16'b0110_1011_0011_1100); // Right shift by 2
        test_shift(1, 0, 0, 16'b1001_1001_1010_1100); // Right shift by 4
        test_shift(1, 1, 0, 16'b1110_1000_1101_0110); // Right shift by 8

        // Finish simulation
        $display("All tests passed!");
        $finish;
    end

    // Task to test a single shift case
    task test_shift;
        input reg test_k0, test_k1, test_left;
        input reg [15:0] expected_output;

        begin
            // Apply inputs
            k0 = test_k0;
            k1 = test_k1;
            left = test_left;
            expected_y = expected_output;

            #10; // Wait for output to settle

            // Check output
            if (y !== expected_y) begin
                $display("Test failed for k0=%b, k1=%b, left=%b", k0, k1, left);
                $display("Expected: %b, Got: %b", expected_y, y);
                $stop;
            end else begin
                $display("Test passed for k0=%b, k1=%b, left=%b", k0, k1, left);
            end
        end
    endtask
endmodule
