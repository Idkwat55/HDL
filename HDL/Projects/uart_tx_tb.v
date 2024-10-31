`timescale 1ns / 1ps

module uart_tx_tb;
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
    wire parity_gen_tx;
    // Instantiate the UART module
    uart uut (
        .clk(clk),
        .tx_start(tx_start),
        .datain_tx(datain_tx),
        .tx_out(tx_out),
        .rx_in(rx_in),
        .dataout_rx(dataout_rx),
        .parity_error_rx(parity_error_rx),
        .parity_received(parity_received),
        .parity_gen_tx(parity_gen_tx)
        
    );
    
    // Clock generation
    always #50 clk = ~clk; // 10 MHz clock period -> 100ns per clock 
    // 521 clocks per bit cycles, total time for bit cycle is 100ns*521
   // reg [6:0] data =    7'b101_0101 ;// 101_0101
    reg [6:0] data =    7'b111_1111 ;
    reg [7:0] d1 = 0;
    //reg [7:0]  d2 = 8'b101_0101_0;
    reg [7:0]  d2 = 8'b111_1111_1;
    
   initial begin
    // Initialize signals
    clk = 0;
    tx_start = 0;
    datain_tx = data;
    $display("Starting Transmission:");
    $display("Data is: %07b", data);
    $monitor(" $$ \t tx_out: %d \t tx_start:%d \t datain_tx:%b \t data:%b \t d1:%b \t d2:%b \t parity_gen_tx:%b",
    tx_out, tx_start, datain_tx, data,d1,d2,parity_gen_tx);
    #52100;
    tx_start = 1;
    #52100;
    d1[0] = tx_out; #52100;
    d1[1] = tx_out; #52100;
    d1[2] = tx_out; #52100;
    d1[3] = tx_out; #52100;
    d1[4] = tx_out; #52100;
    d1[5] = tx_out; #52100;
    d1[6] = tx_out; #52100;
    d1[7] = tx_out; #52100;
#52100; 
tx_start=0;
#52100;

 // 7 bit data with lsb parity

    // Check if the received data matches the expected data
    if (d1 ==d2)  
        $display("       ###    T E S T  - 1 P A S S E D       ###  ");
   else 
    $display("       ###    T E S T  - 1 F A I L E D       ###  ");   

    $display("       ###    FINISHED TESTING           ###  ");
    // Finish the simulation
    $finish;
    $stop;
end

 

endmodule
