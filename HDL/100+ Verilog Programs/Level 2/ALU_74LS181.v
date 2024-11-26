`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2024 13:54:51
// Design Name: 
// Module Name: ALU_74LS181
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

`default_nettype none

module ALU_74LS181(
input wire [3:0] A_, B_, S,
input wire M, Cn,  
output reg [3:0] F_,
output reg AeqB, G_, P_, Cn4
    );
   
parameter L = 1'b0;
parameter H = 1'b1;

 
 
    
always@(A_ or B_ or S or M or Cn) begin
 
case(S)

{L,L,L,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = ~(A_); // ~A
    if ( {M,Cn} === 2'b00 )
    F_ = A_ - 1; // A - 1
    if ( {M,Cn} === 2'b11 )
    F_ = ~ A_; // ~A 
    if ( {M,Cn} === 2'b01 )
    F_ = A_; // A
    end 
    
{L,L,L,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = ~(A_ & B_); // ~ A.B
    if ( {M,Cn} === 2'b00 )
    F_ = (A_ & B_) - 1; 
    if ( {M,Cn} === 2'b11 )
    F_ = ~(A_ | B_);
    if ( {M,Cn} === 2'b01 )
    F_ = (A_ | B_);
end    

{L,L,H,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = ~(A_ | B_);
    if ( {M,Cn} === 2'b00 )
    F_ = (A_ & (~(B_)) ) - 1;
    if ( {M,Cn} === 2'b11 )
    F_ = ~(A_) & ( B_);
    if ( {M,Cn} === 2'b01 )
    F_ = (A_ | (~(B_)) );
end   

{L,L,H,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = 1 - 1 ;
    if ( {M,Cn} === 2'b00 )
    F_ = 1 - 1 ;
    if ( {M,Cn} === 2'b11 )
    F_ = $signed(4'b0000 - 1'b1);
    if ( {M,Cn} === 2'b01 )
    F_ = $signed(4'b0000 - 1'b1);
end

{L,H,L,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = ~ (A_ | B_ );
    if ( {M,Cn} === 2'b00 )
    F_ = A_ + ( A_ | (~(B_)) );
    if ( {M,Cn} === 2'b11 )
    F_ = ~( A_ & B_ ) ;
    if ( {M,Cn} === 2'b01 )
    F_ = A_ + ( A_ &  (~(B_)) );
end

{L,H,L,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = ~ ( B_ );
    if ( {M,Cn} === 2'b00 )
    F_ = (A_ & B_) + ( A_ | (~B_) );
    if ( {M,Cn} === 2'b11 )
    F_ = ~( B_ ) ;
    if ( {M,Cn} === 2'b01 )
    F_ = (A_ | B_ ) + ( A_ &  (~(B_)) );
end

{L,H,H,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = ~ (A_ ^ B_ );
    if ( {M,Cn} === 2'b00 )
    F_ = A_ - B_ - 1;
    if ( {M,Cn} === 2'b11 )
    F_ = A_ ^ B_  ;
    if ( {M,Cn} === 2'b01 )
    F_ =  A_ - B_ - 1;
end

{L,H,H,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = A_ | (~(B_));
    if ( {M,Cn} === 2'b00 )
    F_ = A_ | (~(B_));
    if ( {M,Cn} === 2'b11 )
    F_ = A_ & (~( B_ )) ;
    if ( {M,Cn} === 2'b01 )
    F_ =  (A_ & B_ ) - 1;
end

{H,L,L,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = (~A_) & B_;
    if ( {M,Cn} === 2'b00 )
    F_ = A_ + (A_ | B_);
    if ( {M,Cn} === 2'b11 )
    F_ = (~A_) |  B_ ;
    if ( {M,Cn} === 2'b01 )
    F_ =  A_ + (A_ & B_ ) ;
end

{H,L,L,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = A_ ^ B_;
    if ( {M,Cn} === 2'b00 )
    F_ = A_ +  B_;
    if ( {M,Cn} === 2'b11 )
    F_ = ~ (A_ ^ B_);
    if ( {M,Cn} === 2'b01 )
    F_ =  A_ + B_ ;
end

{H,L,H,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = B_;
    if ( {M,Cn} === 2'b00 )
    F_ = (A_ & B_) + (A_ | B_);
    if ( {M,Cn} === 2'b11 )
    F_ = B_;
    if ( {M,Cn} === 2'b01 )
    F_ =  (A_ | B_) + (A_ & B_);
end

{H,L,H,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = A_ | B_;
    if ( {M,Cn} === 2'b00 )
    F_ = A_ | B_;
    if ( {M,Cn} === 2'b11 )
    F_ = A_ & B_;
    if ( {M,Cn} === 2'b01 )
    F_ = (A_ & B_) - 1;
end

{H,H,L,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = 1'b0;
    if ( {M,Cn} === 2'b00 )
    F_ = A_ + (~A_);
    if ( {M,Cn} === 2'b11 )
    F_ = 1'b1;
    if ( {M,Cn} === 2'b01 )
    F_ = A_ + (~A_);
end

{H,H,L,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = A_ & (~B_);
    if ( {M,Cn} === 2'b00 )
    F_ = (A_ & B_) + A_;
    if ( {M,Cn} === 2'b11 )
    F_ = A_ | (~B_);
    if ( {M,Cn} === 2'b01 )
    F_ = (A_ | B_) + A_;
end

{H,H,H,L}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = A_ & (B_);
    if ( {M,Cn} === 2'b00 )
    F_ = (A_ & (~B_)) + A_;
    if ( {M,Cn} === 2'b11 )
    F_ = A_ | (B_);
    if ( {M,Cn} === 2'b01 )
    F_ = (A_ & (~B_)) + A_;
end

{H,H,H,H}: begin
    if ( {M,Cn} === 2'b10 )
    F_ = A_ ;
    if ( {M,Cn} === 2'b00 )
    F_ = A_ ;
    if ( {M,Cn} === 2'b11 )
    F_ = A_ ;
    if ( {M,Cn} === 2'b01 )
    F_ = A_ - 1;
end

endcase

end    
    
    
    
endmodule



module propagate_adder(
input wire [3:0] a,b,
input wire cin,
output reg [3:0] sum,
output reg carry, cP, cG
    );
    
    // g_i  = a_i & b_i 
    // p_i  = a_i ^ b_i 
    // s_i  = p_i ^ c_i
    // c_1+1= g_i | (c_i & p_i)
 
reg [2:0] i = 0 ;
reg [3:0] g,p;
reg [4:0] c;
 
always@(a or b or cin) begin
c = 5'b00000;
c[0] = cin;

for (i = 0; i<4; i = i + 1) begin
g[i] = a[i] & b[i];
p[i] = a[i] ^ b[i];
sum[i] = p[i] ^ c[i];
c[i+1] = g[i] | (c[i] & p[i]);
end
carry = c[4];
cP = p[3] & p[2]& p[1] &p[0];
cG = g[3] | (p[3] & g[3]) |  (p[3] & p[2] & g[1]) | (p[3]&p[2]&p[1]&g[0]) ;
end    

endmodule
