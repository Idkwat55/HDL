`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2024 17:41:08
// Design Name: 
// Module Name: debouncer
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


module debouncer(
input wire clk, rst_, en, data,
input wire [1:0] period,
output reg dout
    );
 
    // for a 10Mhz clock, with debounce periods 5ms, 10 ms, 20ms, 50ms. 
    // 5ms - 50,000 clks, 10ms -100,000.0, 20ms - 200,000.0, 50ms - 500,000.0
    
    reg [18:0] counter ,tar_val ;
    reg capt_data;
    
    always@(posedge clk or negedge rst_) begin
        if (!rst_) begin
            counter <=0;
            tar_val <=0;
            capt_data <=0;
        end
        if (en) begin
            case (period)
                2'b00: tar_val = 'd500_000;
                2'b01: tar_val = 'd100_000;
                2'b10: tar_val = 'd200_000;
                2'b11: tar_val = 'd500_000;
            endcase
            capt_data <= data;
            if (counter == (tar_val-1)) begin
                if (data == capt_data)
                    dout <= capt_data;
                else 
                    dout <= ~capt_data;
            end
            else
                counter <= counter+1;
        end
        else
            dout <= data;
    end
    
endmodule
