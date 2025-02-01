//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

// 4 bit incrementor / up - counter

module incrementor4b(
    input d, clk,rst_,
    output reg [3:0] count
);

    always@(posedge clk or negedge rst_) begin
        if (!rst_)
            count <= 4'b0000;
        else if (d)
            count <= count + 1;

    end

endmodule
