<<<<<<< HEAD
module spi_master (
    input wire CLK, RST_,
    input wire  [1:0] CSi,
    input wire  MISO, CPOL, CPHA, Tx_En,
    input wire  [7:0] Tx_DATA,
    output reg MOSI,SCK,
    output reg  [7:0] Rx_DATA,
    output wire [3:0] CSo,
    output reg BUSY, TC
);

    localparam idle = 'b00;
    localparam transfer = 'b01;

    localparam frame_size = 'b1000;

    wire gclk, gclkb;
    reg sck_en, sck_rst, idle_v;
    reg [7:0] TxD_reg, RxD_reg;
    reg [3:0] transfer_state, bit_count;

    SCK_gen SCK_generator (.clk(CLK), .clk_en(sck_en), .RST_(sck_rst), .gclk(gclk), .gclkb(gclkb));
    decoder decoder_1 (CSi, CSo);

    always @ (posedge SCK) begin
        if (transfer_state == transfer) begin
            if (CPHA == 0) begin
                RxD_reg[0] <= MISO;
                RxD_reg <= RxD_reg << 1;
                bit_count <= bit_count + 1;
                if ((bit_count + 1) == frame_size) begin
                    transfer_state <= idle;
                    TC <= 1;
                    BUSY <= 0;
                end
            end
        end
        else begin
            MOSI <= TxD_reg[7];
            TxD_reg <= TxD_reg << 1;
        end
    end

    always@(negedge SCK) begin
        if (transfer_state == transfer) begin
            if (CPHA == 0) begin
                MOSI <= TxD_reg[7];
                TxD_reg <= TxD_reg << 1;
            end
        end
        else begin
            RxD_reg[0] <= MISO;
            RxD_reg <= RxD_reg << 1;
            bit_count <= bit_count + 1;
            if ((bit_count + 1) == frame_size) begin
                transfer_state <= idle;
                TC <= 1;
                BUSY <= 0;
            end
        end

    end

    always@( posedge CLK or negedge RST_) begin
        if (!RST_) begin
            sck_rst <= 0;
            sck_en  <=0;
            BUSY <= 0;
            TC <= 0;
            Rx_DATA <= 0;
            MOSI <= 0;
            SCK <= 0;
            transfer_state<= idle;
        end
        else begin
            sck_rst <= 1;
            if (sck_en)
                SCK <= gclk;
            TxD_reg <= Tx_DATA;
            if (CPOL == 0)
                idle_v <= 0;
            else
                idle_v <= 1;
            case (transfer_state)
                idle : begin
                    SCK <= idle_v;
                    sck_en <= 0;
                    if (Tx_En) begin
                        sck_en <= 1;
                        transfer_state <= transfer;
                    end
                end
            endcase
        end
    end
endmodule

module SCK_gen (
    input wire clk, clk_en, RST_,
    output reg gclk, gclkb
);

    reg [3:0] count;

    always@(posedge clk or negedge RST_) begin
        if (!RST_) begin
            count <= 0;
            gclk <= 0;
            gclkb <= 1;
        end
        else begin
            count <= count + 1;
            if (count == 'b0100) begin
                if (clk_en) begin
                    gclk <= ~ gclk;
                    gclkb <= ~ gclkb;
                end
                count <= 'b0000;
=======

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
>>>>>>> 90ea5ce8800e7f20edb45ba2d6e7c778c26fb768
            end
        end
    end

    always @(SCK != idle) begin : receive_CPHA_0
        if (receiving && !CPHA)  begin
            rx_buff <= {rx_buff[frame_size - 2:0], MISO};
        end
    end

<<<<<<< HEAD
module decoder (
    input wire [1:0] a,
    output reg [3:0] b);

    always @ (a) begin
        case (a)
            'd0: b <= ~ 'b0001;
            'd1: b <= ~ 'b0010;
            'd2: b <= ~ 'b0100;
            'd3: b <= ~ 'b1000;
        endcase
    end

=======
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


>>>>>>> 90ea5ce8800e7f20edb45ba2d6e7c778c26fb768
endmodule