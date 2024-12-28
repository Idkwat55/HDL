`timescale 1ns / 1ps

module UART_Tx_tb;

  // Tx signals
  reg [7:0] din;
  reg clk, rst_, trigger;
  wire dout, busy;

  // Rx signals
  wire [7:0] Dout;
  wire Dvalid;
  wire tns;  // Transmitted signal from UART_Tx
 integer i;
  // Instantiate UART Transmitter
  UART_Tx Txu (
    .din(din),
    .clk(clk),
    .rst_(rst_),
    .trigger(trigger),
    .dout(tns),
    .busy(busy)
  );

  // Instantiate UART Receiver
  UART_Rx Rxu (
    .Dout(Dout),
    .Din(tns),
    .clk(clk),
    .rst_(rst_),
    .Dvalid(Dvalid)
  );

  // Clock generation (50 MHz clock)
  always begin
    #10 clk = ~clk;  // 50 MHz clock (20 ns period)
  end

  // ASCII Characters to Send
  localparam one = 8'b11111111;
  localparam H = 8'b01001000;  // ASCII 'H'
  localparam E = 8'b01000101;  // ASCII 'E'
  localparam L = 8'b01001100;  // ASCII 'L'
  localparam O = 8'b01001111;  // ASCII 'O'
  localparam B = 8'b01000010;  // ASCII 'B'

  reg [7:0] test_data [0:5];  // Array for test data (6 characters)

  // Monitor Dout and Dvalid values
  initial begin
    $monitor("At time %0t: Dout = %b, Dvalid = %b", $time, Dout, Dvalid);
  end

  // Test procedure
  initial begin
    // Initialize signals
    clk = 0;
    rst_ = 1;
    din = 8'b00000000;
    trigger = 0;

    // Initialize test data
    test_data[0] = one;
    test_data[1] = H;
    test_data[2] = E;
    test_data[3] = L;
    test_data[4] = L;
    test_data[5] = O;

    // Apply reset
    #0 rst_ = 0;  // Assert reset at time 0
    #10 rst_ = 1;  // Release reset after 10 ns

    // Wait for system to stabilize
    #10;

    // Send the test data using trigger
    // First character 'A' (0x41)
    din = 8'b01000001;  // ASCII 'A'
    trigger = 1;
    #0.5;  // wait 0.5 us
    trigger = 0;
    #103.1;  // wait 103.1 us

    // Second character 'U' (0x55)
    din = 8'b01010101;  // ASCII 'U'
    trigger = 1;
    #0.5;  // wait 0.5 us
    trigger = 0;
    #103.1;  // wait 103.1 us

    // Send all test data (loop through the array)
   
    for (i = 1; i < 6; i = i + 1) begin
      din = test_data[i];  // Load each character from the array
      trigger = 1;
      #0.5;  // wait 0.5 us
      trigger = 0;
      #103.1;  // wait 103.1 us
    end

    // Finish the simulation
    #10;
    $finish;
  end

endmodule
