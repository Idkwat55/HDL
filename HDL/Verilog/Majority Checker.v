//Output Y is High if atleast 2 inputs are high
                                         		
module Majority (A, B, C, Y);                 	
   input  A, B, C;			
   output Y; 

   reg Y;           		
                   	          	
 
assign Y = (A & B) | (B & C ) | ( A & C );

endmodule 




    