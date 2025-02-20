`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/*
    Clock Divider :

    - Dividing a clock by a factor 'f' results in a new clock whose period is 'f' times
        longer, and whose speed is 'f' times slower
    
    Ex :
        Divide by 2 
        If original clock operates at 100Mhz, for 10ns period, a by 2 divider results
            in a clock that has a frequency of 50Mhz, and 20ns periods
*/
//////////////////////////////////////////////////////////////////////////////////

// Power of 2 clock divider, 2, 4, 8 ,16, 32, 64, 128 , 256


module clock_divider(
    input wire clk, en, rst_,
    input wire [2:0] div,
    output reg clk_out
);

    reg  [7:0] counter, tar_clk;

    /*
    function [7:0] clockVal (input [2:0] div) ;
        case (div)
            'd0: clockVal = 'd1;
            'd1: clockVal = 'd3;
            'd2: clockVal = 'd7;
            'd3: clockVal = 'd15;
            'd4: clockVal = 'd31;
            'd5: clockVal = 'd63;
            'd6: clockVal = 'd127;
            'd7: clockVal = 'd255;
            default: clockVal ='d1;
        endcase
    endfunction */

    always@(posedge clk or negedge rst_ )begin
        if (!rst_) begin
            clk_out <= 0;
            counter <= 0;
            tar_clk <= 0;
        end
        if (en) begin
            if (counter ==( (div == 'd0) ?  8'd1 : (div == 'd1) ?  8'd3 : (div == 'd2) ?  8'd7 : (div == 'd3) ?  8'd15 : (div == 'd4) ?  8'd31 : (div == 'd5) ?  8'd63 : (div ==  'd6) ?  8'd127 : (div ==  'd7) ?  8'd255 : 8'd1)) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end
            else
                counter <= counter+1;
        end
    end

endmodule
