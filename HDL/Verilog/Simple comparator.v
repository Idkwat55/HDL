 
module Comparator2(
   input [1:0] A, B,
   output reg Equals
);  
 always @(A,B) begin
if (A ==B) begin
Equals = 1;
end
else begin 
Equals = 0;
end
end
 

endmodule  




    