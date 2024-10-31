`timescale 1ns / 1ps

module uart_tb;
    // Clock and reset
    reg clk;
    
    // TX Signals
    reg tx_start;
    reg [6:0] datain_tx;
    wire tx_out;
    
    // RX Signals
    reg rx_in;
    wire [6:0] dataout_rx;
    wire parity_error_rx;
    
    // Instantiate the UART module
    uart uut (
        .clk(clk),
        .tx_start(tx_start),
        .datain_tx(datain_tx),
        .tx_out(tx_out),
        .rx_in(rx_in),
        .dataout_rx(dataout_rx),
        .parity_error_rx(parity_error_rx),
        .parity_received(parity_received)
    );
    
    // Clock generation
    always #50 clk = ~clk; // 10 MHz clock period -> 100ns per clock 
    // 521 clocks per bit cycles, total time for bit cycle is 100ns*521
    reg [6:0] data =    7'b101_1011 ;
    reg [6:0] data2 = 7'b111_0001;
    reg [6:0] d1 = 0;
    reg [6:0] d2 = 0;
    
    
   initial begin
    // Initialize signals
    clk = 0;

    $display("Starting reception:");
    $display("Data is: %07b", data);
    $monitor(" $$ \t rx_in: %d \t data:'b%07b \t data2:%b \t dataout_rx:'b%b \t d1:%b \t d2%b \t parity_error_rx:%b \t parity_received:%b",
    rx_in ,data,data2, dataout_rx,d1,d2, parity_error_rx , parity_received  );
    // Begin data reception
    rx_in = 1; #52100;  // Initial idle state
    
    // Data transmission in LSB-first order
    rx_in = 0; #52100;        // Start bit
    rx_in = data[0]; #52100;  // d0
    rx_in = data[1]; #52100;  // d1
    rx_in = data[2]; #52100;  // d2
    rx_in = data[3]; #52100;  // d3
    rx_in = data[4]; #52100;  // d4
    rx_in = data[5]; #52100;  // d5
    rx_in = data[6]; #52100;  // d6 (MSB)
    rx_in = 1'b1; #52100;     // Parity bit  
    rx_in = 1;    // Stop bit
    
    // Add delay to allow data to propagate to dataout_rx
    #1000;
d1 = dataout_rx;


data2 = 7'b111_0001;
    rx_in = 1; #52100;
    // Data transmission in LSB-first order
    rx_in = 0; #52100;        // Start bit
    rx_in = data2[0]; #52100;  // d0
    rx_in = data2[1]; #52100;  // d1
    rx_in = data2[2]; #52100;  // d2
    rx_in = data2[3]; #52100;  // d3
    rx_in = data2[4]; #52100;  // d4
    rx_in = data2[5]; #52100;  // d5
    rx_in = data2[6]; #52100;  // d6 (MSB)
    rx_in = 1'b0; #52100;     // Parity bit  
    rx_in = 1;    // Stop bit
    d2 = dataout_rx;
    // Add delay to allow data to propagate to dataout_rx
    #1000;

d2 = dataout_rx;

    // Check if the received data matches the expected data
    if (data == d1) begin
        $display("       ###    T E S T  - 1 P A S S E D       ###  ");
        if (data2 == d2)
         $display("       ###    T E S T  - 2 P A S S E D       ###  ");
         else 
         $display("       ###    T E S T - 2  F A I L E D       ###  ");
    end else
    $display("       ###    T E S T  - 1 F A I L E D       ###  ");   

    $display("       ###    FINISHED TESTING           ###  ");
    // Finish the simulation
    $finish;
    $stop;
end

 

endmodule
