`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2024 17:39:53
// Design Name: 
// Module Name: dualPort_ram
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

// Based on DS1609 

module dualPort_ram(
inout wire [7:0] ADa, ADb, // Address/Data
input CEa_, CEb_,  //Port Enable
input WEa_, WEb_, //Write Enable
input OEa_, OEb_  // Output Enable
    );
    
    reg [7:0] ram [255:0];
    reg [7:0] addr_a, addr_b;
    
    
assign ADa = (WEa_) ? ( (!CEa_) ? ( (!OEa_) ? ram[addr_a] : 8'bZ) : 8'bZ ) : 8'bZ;
assign ADb = (WEb_) ? ( (!CEb_) ? ( (!OEb_) ? ram[addr_b] : 8'bZ) : 8'bZ ) : 8'bZ;
   
     
   
     always@(*) begin
     if (!CEa_) 
        addr_a = ADa;
     if (!CEb_)
         addr_b = ADb;
      if (!WEa_ & !CEa_)
      ram[addr_a] = ADa;
      if (!WEb_ & !CEb_)
      ram[addr_b] = ADb;  
     end
    
    
endmodule
