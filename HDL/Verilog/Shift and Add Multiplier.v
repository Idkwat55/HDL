module shift_add_mult(a,b,p);
input wire  [7:0] a, b;
output reg [15:0]p;

reg [15:0] a1,b1; 

integer i= 0;
always @(*) begin
p = {15'b0,0};
a1 = {15'b0,a};
b1 = b;

for (i = 0; i<7;i = i +1) begin

if (b1[0]==1) begin
p = p + a1;
a1 = a1<<1;
b1 = b1>>1;
end
else begin
a1 = a1<<1;
b1 = b1>>1;
end
 
end 

end

endmodule
