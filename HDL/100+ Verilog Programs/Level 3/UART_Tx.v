`timescale 1ns / 1ps

// 10Mhz clk. 
// 9600 8N1 : 
// buad rate 9600, bit period = 104us



//For a 10 MHz clock, the `CLKS_PER_BIT` value can be calculated using the formula:


//CLKS_PER_BIT = Clock Frequency (Hz) / Baud Rate (bits/sec)


//Here's a table with calculations for some common baud rates:

//| Baud Rate(bits/sec)       | CLKS_PER_BIT (exact)    | CLKS_PER_BIT (rounded)      | Actual Baud Rate (bits/sec)     |
//|---------------------------|-------------------------|-----------------------------|---------------------------------|
//| 300                       | 33,333.33               | 33,333                      | 300.0                           |
//| 9,600                     | 1,041.67                | 1,042                       | 9,596.1                         |
//| 19,200                    | 520.83                  | 521                         | 19,192.7                        |
//| 38,400                    | 260.42                  | 260                         | 38,461.5                        |
//| 57,600                    | 173.61                  | 174                         | 57,471.3                        |
//| 115,200                   | 86.81                   | 87                          | 114,942.5                       |





module UART_Tx #(
    parameter baud_rate = 32'd1042 , // 9600 baud, actual 9,596.1 // 9600 baud, actual 9,596.1 [ 10 * (10**6) / 9600  = 1041.6666666666667 = 1042 counts]
    parameter bits_per_frame = 8'd8
)(
    input wire [7:0] din,
    input wire clk, rst_, trigger,
    output reg dout, busy
);


    localparam start = 2'b00;
    localparam transmit= 2'b01;
    localparam stop = 2'b10;


    reg [7:0] data_reg;
    reg [31:0] baud_counter;
    reg [7:0] bit_counter;
    reg [1:0] state;
    reg tmp;

    always@(posedge clk or negedge rst_) begin

        if (!rst_) begin
            data_reg <= 0;
            baud_counter<=0;
            dout<=1;
            busy<= 0;
            state<= stop;
            bit_counter <= 0;
            tmp <= 0;
        end

        else begin
            /* verilator lint_off CASEINCOMPLETE */
            case (state)

                stop: begin
                    if (trigger) begin
                        tmp <= 1;
                    end

                    dout<= 1;
                    busy<= 0;
                    if (tmp)
                        baud_counter <= baud_counter + 1;
                    if (baud_counter == baud_rate) begin
                        if (tmp)
                            state<= start;
                        baud_counter <= 0;
                    end

                end

                start: begin
                    dout<=0;
                    busy<= 1;
                    baud_counter <= baud_counter + 1;
                    if (baud_counter == baud_rate) begin
                        state<= transmit;
                        data_reg<= din;
                        baud_counter <= 0;
                        bit_counter<=0;
                    end
                end

                transmit: begin
                    dout<= data_reg[0];
                    baud_counter<= baud_counter + 1;
                    if (baud_counter == baud_rate  ) begin
                        if (bit_counter + 1 == bits_per_frame) begin
                            baud_counter <= 0;
                            state <= stop;
                            tmp <= 0;
                        end
                        bit_counter <= bit_counter + 1;
                        data_reg<= data_reg >> 1;
                        baud_counter <= 0;

                    end

                end


            endcase

        end

    end



endmodule
