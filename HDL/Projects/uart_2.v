`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2024 17:29:32
// Design Name: 
// Module Name: uart
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


// DTE - data terminal device UART
// 7 data bits, 1 evven parity, full duplex, 
//rx_in, tx_out are  the  line for the rx/tx pair of uart, dataout_rx is for the cpu that uses the uart
//i_clock -> determines baud rate / bit period , 
module uar_2 ( 
//common
input clk,

////  TX 

input tx_start,
input [6:0]datain_tx,
output reg tx_out, 


//// RX
input rx_in,

output reg [6:0] dataout_rx , 
output reg parity_error_rx,
output reg parity_received 
);
    
    
// common parameters

parameter idle = 3'b000;
parameter start =3'b001;
parameter data = 3'b010;
parameter stop = 3'b011;


//// RX 

reg [2:0]  curr_state_rx = idle;
reg [3:0]  bit_index_rx  = 7; // 8-> parity, 7,6,5,4,3,2,1 -> 7 bits, rx receives parity then d6,d5..d0
                              // when it reaches 0, bit_index and baud_count are reset  
                              // for safety 1 bit extra , also cuz 8 in bin is 1000 so 3bits needed : can be optimized for only using 3 bits but im done
reg [6:0]  dout_reg_rx   = 0; 
reg [11:0] baud_count_rx = 0; // for safety 1 bit extra 

reg parity_received  = 0;
 
reg parity_gen_rx    = 0;

//// TX

reg [2:0]  curr_state_tx = idle;
reg [3:0]  bit_index_tx  = 8;
reg [6:0]  dout_reg_tx   = 0; // not needed
reg [11:0] baud_count_tx = 0;

reg parity_gen_tx = 0;

 //baud_tick_count is bit period
parameter baud_tick_count = 521; // gbl clk /19200, 10Mhz gbl -> 520.8333333333334 -> 521  // clock per bit cycle
parameter bit_count = 8; // 7 data bits . 8 total bits including parity

// TX frames as -  Start bit ? d0 ? d1 ? d2 ? d3 ? d4 ? d5 ? d6 ? p0 ? Stop bit(s)  
// with p0 parity and rest data
// thus at RX, first bit received is actually parity, then d6, then d5 .... finally d0


always@(posedge clk) begin

 /////////// RX //////////////


case (curr_state_rx) 
 
// idle state start
idle: begin
if (rx_in == 1'b0) begin
curr_state_rx <= start;
dataout_rx <='bz;
end
baud_count_rx  <= 0;
parity_received<='bz;
dout_reg_rx<=0;
bit_index_rx <= 7;
parity_error_rx <= 0;
end
// idle state END


// start state start
start: begin                   // ------------------
if (baud_count_rx== baud_tick_count>>1) begin //waiting for half bit period
baud_count_rx <=0;
curr_state_rx <= data;
end 
else 
baud_count_rx <= baud_count_rx+1;
end                            // ------------------
// start state END


// data state start
data: begin                   // ------------------
if (baud_count_rx  == baud_tick_count) begin
   
// capture parity
if (bit_index_rx == 0)  begin
parity_received <= rx_in;
bit_index_rx <= bit_index_rx-1;
baud_count_rx <= 0;
end
else begin 
// data capture
dout_reg_rx[bit_index_rx-1] <= rx_in;      // dout_reg_rx capture d6 to d0, 
bit_index_rx  <= bit_index_rx -1;
baud_count_rx <= 0;
end 
if (bit_index_rx == 0) begin  // bit_count = 8 for p0 + d6-d0, when at 0 reset 
curr_state_rx <= stop;        //for bit_index = 0, parity, from 1 to 7 -> 7 bits are data  
baud_count_rx <= 0;
end   
end
else begin
baud_count_rx<= baud_count_rx+1;
end 
end                        // ------------------
// data state END

// stop state start
stop: begin
parity_gen_rx <= (dout_reg_rx[0]^ dout_reg_rx[1]^ dout_reg_rx[2]^ dout_reg_rx[3]^ dout_reg_rx[4]^ dout_reg_rx[5]^ dout_reg_rx[6] );
parity_error_rx =  (parity_received ~^ parity_gen_rx);   //// if no error , then high parity error flag generation : xnor
dataout_rx <= {<<{dout_reg_rx}}; // Bit-reversal with replication operator

curr_state_rx <=idle;
end
// stop state END

//end case
endcase
//end always
end



////////////////// TX section ///////////
always@(posedge clk) begin

case (curr_state_tx)  

idle: begin
if (tx_start) begin
curr_state_tx <= start;
end
baud_count_tx  <= 0;
bit_index_tx <= 8;
parity_gen_tx <=0;
tx_out <= 1;
end


start: begin
tx_out <= 0;
if (baud_count_tx== baud_tick_count>>1 ) begin //waiting for half bit period
baud_count_tx <=0;
curr_state_tx <= data;
end 
else 
baud_count_tx <= baud_count_tx+1;
end


data: begin
if (baud_count_tx  == baud_tick_count) begin
if (bit_index_tx == 8) begin /// send out parity first, 8th bit parity
parity_gen_tx <= (datain_tx[0]^ datain_tx[1]^ datain_tx[2]^ datain_tx[3]^ datain_tx[4]^ datain_tx[5]^ datain_tx[6] );
tx_out <= parity_gen_tx;
bit_index_tx  <= bit_index_tx-1;
end else begin // start sending data 
tx_out <=datain_tx[bit_index_tx];
bit_index_tx  <= bit_index_tx-1;
baud_count_tx <= 0;
if (bit_index_tx == 0) begin  // after 7 bits, plus one parity bit, at 0th bit period stop
curr_state_tx <= stop;
end
end
end
else begin
baud_count_tx<= baud_count_tx+1;
end 
end


stop: begin
if (baud_count_tx == baud_tick_count) begin
tx_out <=0;
curr_state_tx <=idle;
end
else 
baud_count_tx<= baud_count_tx+1;
end

endcase  // endcase

end     // end always



endmodule
