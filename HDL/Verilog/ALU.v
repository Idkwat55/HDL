module ALU ( 
  input [2:0] Op_code,
  input [31:0] A, B,
  output reg [31:0] Y
);

reg [31:0] x;
always @(A or B or Op_code) begin

case (Op_code )

3'b000:
x<=A;
3'b001:
x<= A +  B;
3'b010:
x<=A-B;
3'b011:
x<=A  & B;
3'b100:
x<=A|B;
3'b101:
x<=A+1;
3'b110:
x<=A-1;
3'b111:
x<=B;

default : 
x<=4'bzzzz;

endcase

end

assign Y = x;


endmodule