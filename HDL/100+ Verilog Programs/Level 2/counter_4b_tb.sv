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

counter_4b uut (.*);


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
tc = tc +1;
$finish;
end
if (CO !== exp_CO) begin
$display("== Incorrect CO == : RST_ = %b, M = %b, LD = %b, D = %b, CE = %b Q = %b, CO = %b \t Expected Q = %b, Co = %b",
RST_, M, LD, D, CE, Q, CO,exp_Q,exp_CO);
tc = tc +1;
$finish;
end

endtask;


initial begin
$monitor("== Monitor == : RST_ = %b, M = %b, LD = %b, D = %b, CE = %b Q = %b, CO = %b",
RST_, M, LD, D, CE, Q, CO);
forever begin
CLK = ~CLK;
#5;
end
end

initial begin
CLK = 0;
tc = 0;
$display("== INITIAL == : RST_ = %b, M = %b, LD = %b, D = %b, CE = %b Q = %b, CO = %b",
RST_, M, LD, D, CE, Q, CO);
#10;

RST_ = 0;
M = 0; LD = 0; CE = 0; D = 4'b0000;
#10;

$display("== After Reset == : RST_ = %b, M = %b, LD = %b, D = %b, CE = %b Q = %b, CO = %b",
RST_, M, LD, D, CE, Q, CO);

 




qreg = 4'b0000;
coreg = 1'b0;
M = 1;
RST_ =1; //release rst
#10;
M = 0; #10;

for (i = 0; i < 16; i =i+1) begin
 
if (qreg === 4'b1111) begin
coreg = 1'b1;
end
#10;
counter (qreg,coreg);

qreg = qreg + 1; 

end


$display("\t\t PASSED ");
$stop;


end




endmodule
