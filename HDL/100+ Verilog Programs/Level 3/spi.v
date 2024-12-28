module spi_master (
    input wire CLK, RST_,
    input wire [1:0] CSi,
    input wire MISO, CPOL, CPHA, Tx_En,
    input wire [7:0] Tx_DATA,
    output reg MOSI, SCK,
    output reg [7:0] Rx_DATA,
    output reg [3:0] CSo,
    output reg BUSY, TC
);

// Parameters for state machine
localparam idle = 1'b0;
localparam transfer = 1'b1;

localparam frame_size = 4'b1000; // 8 bits per frame

// Internal registers
reg [7:0] TxD_reg, RxD_reg;
reg [3:0] bit_count;
reg transfer_state;
reg sck_en, sck_rst;
wire gclk, gclkb;

// Instantiate the SCK generator and decoder
SCK_gen SCK_generator (
    .clk(CLK),
    .clk_en(sck_en),
    .RST_(RST_),
    .gclk(gclk),
    .gclkb(gclkb)
);

decoder decoder_1 (
    .a(CSi),
    .b(CSo)
);

// SCK assignment
always @(posedge gclk or negedge RST_) begin
    if (!RST_)
        SCK <= CPOL; // Reset SCK to idle state based on CPOL
    else if (sck_en)
        SCK <= gclk;
end

// State machine and data transfer logic
always @(posedge CLK or negedge RST_) begin
    if (!RST_) begin
        // Reset all registers
        transfer_state <= idle;
        sck_en <= 0;
        sck_rst <= 1;
        BUSY <= 0;
        TC <= 0;
        Rx_DATA <= 8'b0;
        MOSI <= 0;
        TxD_reg <= 8'b0;
        RxD_reg <= 8'b0;
        bit_count <= 4'b0;
    end else begin
        case (transfer_state)
            idle: begin
                // Idle state
                SCK <= CPOL;
                sck_en <= 0;
                BUSY <= 0;
                TC <= 0;

                if (Tx_En) begin
                    // Start transfer
                    sck_en <= 1;
                    transfer_state <= transfer;
                    BUSY <= 1;
                    TxD_reg <= Tx_DATA; // Load data to transmit
                    bit_count <= 0;
                end
            end

            transfer: begin
                // Data transfer state
                if (SCK == (CPOL ? ~gclk : gclk)) begin
                    if (CPHA == 0) begin
                        // Sample MISO on active clock edge for CPHA = 0
                        RxD_reg[0] <= MISO;
                        RxD_reg <= RxD_reg << 1;
                    end else begin
                        // Shift out MOSI on active clock edge for CPHA = 1
                        MOSI <= TxD_reg[7];
                        TxD_reg <= TxD_reg << 1;
                    end
                end else begin
                    if (CPHA == 0) begin
                        // Shift out MOSI on inactive clock edge for CPHA = 0
                        MOSI <= TxD_reg[7];
                        TxD_reg <= TxD_reg << 1;
                    end else begin
                        // Sample MISO on inactive clock edge for CPHA = 1
                        RxD_reg[0] <= MISO;
                        RxD_reg <= RxD_reg << 1;
                    end
                end

                // Increment bit count and check for frame completion
                if (bit_count == frame_size - 1) begin
                    transfer_state <= idle;
                    TC <= 1;
                    BUSY <= 0;
                    Rx_DATA <= RxD_reg; // Update received data
                end else begin
                    bit_count <= bit_count + 1;
                end
            end
        endcase
    end
end

endmodule

// SCK generator module
module SCK_gen (
    input wire clk, clk_en, RST_,
    output reg gclk, gclkb
);

reg [3:0] count;

always @(posedge clk or negedge RST_) begin
    if (!RST_) begin
        count <= 0;
        gclk <= 0;
        gclkb <= 1;
    end else begin
        if (clk_en) begin
            count <= count + 1;
            if (count == 4) begin
                gclk <= ~gclk;
                gclkb <= ~gclkb;
                count <= 0;
            end
        end
    end
end

endmodule

// Decoder module
module decoder (
    input wire [1:0] a,
    output reg [3:0] b
);

always @(*) begin
    case (a)
        2'd0: b = 4'b0001;
        2'd1: b = 4'b0010;
        2'd2: b = 4'b0100;
        2'd3: b = 4'b1000;
        default: b = 4'b0000;
    endcase
end

endmodule
