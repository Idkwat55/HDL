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
            end
        end
    end

endmodule

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

endmodule