
//    A basic SPI implementation

//    NOTE : 
//    While there are no issues that I'm aware of (considering I only verified it visually (waveform) in Vivado,
//    that too only for this master module, ie no reception was tested)
//    there are some potential problems I've noticed

//    Potential Problems:
//    Tight setup / hold times
//    Tx_En deassertion in middle of transmission

//    At the moment, there isn't any plans to properly verify this, but as part of the 100 verilog programs project
//    I will eventually write complete testbenches for each module, including this one, right after I finish
//    rest of the 100 programs



module spi_master # (
    parameter
    frame_size = 4'd8, // Data Frame Length
    slave_count = 3'd4 // Slaves devices count (must be power of 2)
)
    (
    input wire clk, rst,
    input wire  [$clog2(slave_count):0] CS_i,
    input wire  MISO, CPOL, CPHA, Tx_En,
    input wire  [frame_size -1:0] Tx_DATA,
    output reg MOSI,SCK,
    output reg  [frame_size:0] Rx_DATA,
    output reg [slave_count - 1:0] CS_o,
    output reg BUSY, done
);

    // CPOL  :- 
    //  0 -> idle low , if 1 -> idle high
    // CPHA  :-
    // 0 -> sampling at rising edge, 1 -> sampling at falling edge 
    // Transmits MSB first, receives MSB first

    localparam idle_low  = 1'b0, idle_high = 1'b1;


    reg [frame_size -1 : 0] tx_buff, rx_buff, bit_count;
    reg [2:0] period_count;
    reg idle, genCLK;
    reg sample_next, transmitting, receiving;
    reg cycle;
    reg[3:0] last_bit_period;
    reg hold;


    always @(posedge clk or posedge rst) begin : reset_block
        if (rst) begin
            idle <= idle_low;
            genCLK <= 0;
            tx_buff <= 0;
            rx_buff <= 0;
            Rx_DATA <= 0;
            BUSY <= 0;
            done <= 0;
            bit_count <= 0;
            period_count <= 0;
            transmitting <= 0;
            sample_next <= 0;
            cycle <= 0;
            last_bit_period <= 0;
            receiving <= 0;
            hold <= 0;
        end
    end


    always @(posedge clk) begin : transmit_block
        if (Tx_En && !BUSY && !hold) begin
            genCLK <= 1;
            receiving <= 1;
            tx_buff <= Tx_DATA;
            BUSY <= 1;
            done <= 0;
            transmitting <= 1;
        end
        if (transmitting) begin
            if (period_count == 0 && cycle ) begin
                MOSI <= tx_buff[frame_size - 1];
                tx_buff <= tx_buff << 1;
                if (bit_count == frame_size - 1) begin
                    last_bit_period <=  1;
                end
                bit_count <= bit_count + 1;
            end
        end
        if (last_bit_period >= 3'd1) begin
            last_bit_period <= last_bit_period + 1;
            if (last_bit_period == 3'd3) begin
                bit_count <= 0;
                genCLK <= 0;
                BUSY <= 0;
                done <= 1;
                transmitting <= 0;
                receiving <= 0;
                genCLK <= 0;
                hold <= 1;
                Rx_DATA <= rx_buff;
            end
            if (last_bit_period == 3'd7) begin
                hold <= 0;
                last_bit_period <= 0;
            end
        end
    end

    always @(SCK != idle) begin : receive_CPHA_0
        if (receiving && !CPHA)  begin
            rx_buff <= {rx_buff[frame_size - 2:0], MISO};
        end
    end

    always @(SCK == idle) begin : receive_CPHA_1
        if (receiving && CPHA) begin
            rx_buff <= {rx_buff[frame_size - 2:0], MISO};
        end
    end




    always @(posedge CPOL or negedge CPOL) begin : set_idle
        if (CPOL)
            idle <= idle_high;
        else
            idle <= idle_low;
    end


    always @(posedge clk) begin : SCK_generator
        if (genCLK) begin
            period_count <= period_count + 1;
            if (period_count == 3) begin // 0 -3 -> 4 cycles
                SCK <= ~ SCK;
                period_count <= 0;
                cycle <= ~cycle;
            end
        end
        else begin
            period_count <= 0;
            SCK <= idle;
        end
    end

    always @(CS_i) begin : Chip_Select
        CS_o <= 1 << CS_i;
    end


endmodule