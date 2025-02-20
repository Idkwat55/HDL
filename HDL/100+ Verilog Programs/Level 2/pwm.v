`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2024 21:19:37
// Design Name: 
// Module Name: pwm
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

// 10Mhz - 100ns
// 1.0ns,1.5ns,2.0ns,2.5ns,3.0ns,3.5ns,4.0ns,4.5ns,5.0ns,
//5.5ns,6.0ns,6.5ns,7.0ns,7.5ns,8.0ns,8.5ns,9.0ns,9.5ns,10.0ns


// First part is factored by 100_000 , second part, within block comments is original

module pwm(
    input wire clk, rst_, en, inc, dec,
    output reg clk_out
);

    reg [31:0] counter, targVal;
    reg [4:0] duty;

    always@(posedge clk or negedge rst_) begin
        if(!rst_) begin
            clk_out <= 0;
            counter <= 0;
            duty <=10;
            targVal <=0;
        end
        if (en) begin
            if((inc && !dec) && duty < 20)
                duty <= duty +1;
            else if((!inc && dec) && duty >1)
                duty <= duty -  1;
            case (duty)
                'd1: targVal = 'd5;
                'd2: targVal =  'd10;
                'd3: targVal = 'd15;
                'd4: targVal = 'd20;
                'd5: targVal = 'd25;
                'd6: targVal = 'd30;
                'd7: targVal = 'd35;
                'd8: targVal = 'd40;
                'd9: targVal = 'd45;
                'd10: targVal = 'd50;
                'd11: targVal = 'd55;
                'd12: targVal = 'd60;
                'd13: targVal = 'd65;
                'd14: targVal = 'd70;
                'd15: targVal = 'd75;
                'd16: targVal = 'd80;
                'd17: targVal = 'd85;
                'd18: targVal = 'd90;
                'd19: targVal = 'd95;
                'd20: targVal = 'd100;
                //10000000
                default : targVal = 'd5000000;
            endcase
            if (counter <= targVal ) begin
                clk_out <= 1;
                counter <= counter + 1;
            end
            else begin
                clk_out <=0;
                counter <= counter + 1;
            end
            if (counter > 'd100)
                counter <= 0;
        end
    end

endmodule


/*module pwm(
input wire clk, rst_, en, inc, dec,
output reg clk_out
    );
    
    reg [31:0] counter, targVal;
    reg [4:0] duty;
    
    always@(posedge clk or negedge rst_) begin
        if(!rst_) begin
            clk_out <= 0;
            counter <= 0;
            duty <=10;
            targVal <=0;
        end 
        if (en) begin
            if((inc && !dec) && duty <= 20)
                duty <= duty +1;
            else if((!inc && dec) && duty >0)
                duty <= duty -  1;
            case (duty) 
                'd1: targVal = 'd500000;
                'd2: targVal =  'd1000000;
                'd3: targVal = 'd1500000;
                'd4: targVal = 'd2000000;
                'd5: targVal = 'd2500000;
                'd6: targVal = 'd3000000;
                'd7: targVal = 'd3500000;
                'd8: targVal = 'd4000000;
                'd9: targVal = 'd4500000;
                'd10: targVal = 'd5000000;
                'd11: targVal = 'd5500000;
                'd12: targVal = 'd6000000;
                'd13: targVal = 'd6500000;
                'd14: targVal = 'd7000000;
                'd15: targVal = 'd7500000;
                'd16: targVal = 'd8000000;
                'd17: targVal = 'd8500000;
                'd18: targVal = 'd9000000;
                'd19: targVal = 'd9500000;
                'd20: targVal = 'd10000000;
                                //10000000
                default : targVal = 'd5000000;
            endcase
            if (counter <= targVal ) begin
                clk_out <= 1;
                counter <= counter + 1;
            end 
            else begin
                clk_out <=0;
                counter <= counter + 1;
            end
            if (counter > 'd10000000)
                counter <= 0;
        end
    end
    
endmodule*/
