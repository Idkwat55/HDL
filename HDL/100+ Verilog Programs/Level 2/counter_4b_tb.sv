`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2024 20:51:49
// Design Name: 
// Module Name: counter_4b_tb
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


module counter_4b_tb;

    reg CLK, RST_, M, LD, CE;
    reg [3:0] D;
    wire [3:0] Q;
    wire CO;

    counter uut (.*);

    reg [31:0] tc;
    reg [3:0] qreg;
    reg coreg;
    integer i;

    task counter;
        input [3:0] exp_Q;
        input exp_CO;

        if (Q !== exp_Q) begin
            $display("== Incorrect Q == : RST_ = %b, M = %b, LD = %b, D = %b, CE = %b Q = %b, CO = %b \t Expected Q = %b, Co = %b",
                RST_, M, LD, D, CE, Q, CO,exp_Q,exp_CO);

            $display("Cases : %d", tc);
            $stop;
        end
        else if (CO !== exp_CO) begin
            $display("== Incorrect CO == : RST_ = %b, M = %b, LD = %b, D = %b, CE = %b Q = %b, CO = %b \t Expected Q = %b, Co = %b",
                RST_, M, LD, D, CE, Q, CO,exp_Q,exp_CO);

            $display("Cases : %d", tc);
            $stop;
        end
        else
            tc = tc +1;
    endtask;


    initial begin : clk_generation
        forever begin
            CLK = ~CLK;
            #5;
        end
    end


    integer file;
    integer console;


    initial begin : main_sim

        file = $fopen("counter.log");
        console = file | 31'b1;
        $fdisplay(console,"\t\t Counter Testbench  (log saved to 'counter.log')" );
        $timeformat(-9, 2, " ns", 10);
        CLK = 0;
        tc = 0;
        $fdisplay(console,"==    INITIAL  == : RST_ = %b\tM = %b\tLD = %b\tD = %b\tCE = %b\tQ = 'b%b\tCO = %b\t Time -: %t",
            RST_, M, LD, D, CE, Q, CO, $realtime);
        #10;

        RST_ = 0;
        #10;

        $fdisplay(console,"== After Reset == : RST_ = %b\tM = %b\tLD = %b\tD = %b\tCE = %b\tQ = 'b%b\tCO = %b\t Time -: %t",
            RST_, M, LD, D, CE, Q, CO,$realtime);
        M = 0; LD = 0; CE = 1; D = 4'b0000; RST_ = 1;

        $fdisplay(console,"==    Force    == : RST_ = %b\tM = %b\tLD = %b\tD = %b\tCE = %b\tQ = 'b%b\tCO = %b\t Time -: %t",
            RST_, M, LD, D, CE, Q, CO,$realtime);
        $fmonitor(console,"==    Monitor  == : RST_ = %b\tM = %b\tLD = %b\tD = %b\tCE = %b\tQ = 'b%b (%2d)\tCO = %b\tCLK=%b\t Time -: %t",
            RST_, M, LD, D, CE, Q, Q, CO, CLK, $realtime);

        qreg = 4'b0000;
        coreg = 1'b0;

        //Check Mode = 0
        for (i = 0; i < 16; i =i+1) begin

            if (qreg === 4'b1111) begin
                coreg = 1'b1;
            end

            counter (qreg,coreg);
            #10;
            qreg = qreg + 1;

        end
        M = 1;
        //Check Mode = 1
        for (i = 0; i < 16; i =i+1) begin

            if (qreg === 4'b0000) begin
                coreg = 1'b1;
            end

            counter (qreg,coreg);
            #10;
            qreg = qreg - 1;
        end
        
        LD = 1; D= 4'b1010;
        
        qreg = 4'b1010;
        coreg = 0;
        #10;
        LD = 0;
   
                for (i = 0; i < 16; i =i+1) begin

            if (qreg === 4'b0000) begin
                coreg = 1'b1;
            end

            counter (qreg,coreg);
            #10;
            qreg = qreg - 1;
        end
        
        $display("\t\t ALL PASS !!!");
        $finish;
    end
endmodule
