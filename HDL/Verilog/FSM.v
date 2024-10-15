module FSM(
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);

reg [1:0] state;
always @(posedge CLK or negedge RST) begin

if (RST) begin
state <= 2'b00;
end

else if (In1) begin 
state <= (state ==2'b11) ? 2'b00 : state +1;
end

end

assign Out1 = state;

endmodule