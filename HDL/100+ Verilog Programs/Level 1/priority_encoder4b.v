//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//4 to 2 

module priority_encoder4b(
    input a,b,c,d,
    output reg q1,q0
);

    always @(a or b or c or d) begin
        casex ( {a, b, c, d} )
            4'b1???: begin q1 = 1; q0 = 1; end
            4'b01??: begin q1 = 1; q0 = 0; end
            4'b001?: begin q1 = 0; q0 = 1; end
            4'b0001: begin q1 = 0; q0 = 0; end
            default: begin q1 = 1'bz; q0 = 1'bz; end
        endcase
    end


endmodule
