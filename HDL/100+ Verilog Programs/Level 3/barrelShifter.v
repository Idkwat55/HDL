`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.11.2024 17:51:05
// Design Name: 
// Module Name: barrelShifter
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


module barrelShifter(
    input wire [15:0] a,      
    input wire k0, k1,k2,k3, left,
    output wire [15:0] y       
);
    wire [15:0] y0, y1, y2,y3,y4;

    genvar i;

    // Pre-shift Block
    generate
        for (i = 0; i < 16; i = i + 1) begin
            mux2to1 m_pre (
                .a(a[i]),       // Left rotation
                .b(a[(i) % 16]),  // Right rotation
                .sel(left), 
                .y(y0[i])
            );
        end
    endgenerate

    // 1
    generate
        for (i = 0; i < 16; i = i + 1) begin
            mux2to1 m_pre (
                .a(y0[i]),       // Left rotation
                .b(y0[(i+1) % 16]),  // Right rotation
                .sel(k0^left), 
                .y(y1[i])
            );
        end
    endgenerate
    
        //2
    generate
        for (i = 0; i < 16; i = i + 1) begin
            mux2to1 m_pre (
                .a(y1[i]),       // Left rotation
                .b(y1[(i+1) % 16]),  // Right rotation
                .sel(k1^left), 
                .y(y2[i])
            );
        end
    endgenerate
    
        // 3
    generate
        for (i = 0; i < 16; i = i + 1) begin
            mux2to1 m_pre (
                .a(y2[i]),       // Left rotation
                .b(y2[(i+1) % 16]),  // Right rotation
                .sel(k2^left), 
                .y(y3[i])
            );
        end
    endgenerate
    
        // 4
    generate
        for (i = 0; i < 16; i = i + 1) begin
            mux2to1 m_pre (
                .a(y3[i]),       // Left rotation
                .b(y3[(i+1) % 16]),  // Right rotation
                .sel(k3^left), 
                .y(y[i])
            );
        end
    endgenerate 
 
 
 
endmodule

// Mux2to1 Module
module mux2to1 (
    input wire a, b, sel,
    output wire y
);

assign y = sel ? b : a;

endmodule




/*module barrelShifter(
    input wire [15:0] a,      
    input wire k0, k1, left,
    output wire [15:0] y       
);
    wire [15:0] y1,y2;            

    //Pre - shift Block
    mux2to1 m01 (.a(a[0]), .b(a[8]), .sel(left), .y(y2[0]));
    mux2to1 m02 (.a(a[1]), .b(a[9]), .sel(left), .y(y2[1]));
    mux2to1 m03 (.a(a[2]), .b(a[10]), .sel(left), .y(y2[2]));
    mux2to1 m04 (.a(a[3]), .b(a[11]), .sel(left), .y(y2[3]));
    mux2to1 m05 (.a(a[4]), .b(a[12]), .sel(left), .y(y2[4]));
    mux2to1 m06 (.a(a[5]), .b(a[13]), .sel(left), .y(y2[5]));
    mux2to1 m07 (.a(a[6]), .b(a[14]), .sel(left), .y(y2[6]));
    mux2to1 m08 (.a(a[7]), .b(a[15]), .sel(left), .y(y2[7]));
    mux2to1 m09 (.a(a[8]), .b(a[0]), .sel(left), .y(y2[8]));
    mux2to1 m010 (.a(a[9]), .b(a[1]), .sel(left), .y(y2[9]));
    mux2to1 m011 (.a(a[10]), .b(a[2]), .sel(left), .y(y2[10]));
    mux2to1 m012 (.a(a[11]), .b(a[3]), .sel(left), .y(y2[11]));
    mux2to1 m013 (.a(a[12]), .b(a[4]), .sel(left), .y(y2[12]));
    mux2to1 m014 (.a(a[13]), .b(a[5]), .sel(left), .y(y2[13]));
    mux2to1 m015 (.a(a[14]), .b(a[6]), .sel(left), .y(y2[14]));
    mux2to1 m016 (.a(a[15]), .b(a[7]), .sel(left), .y(y2[15]));
    
    //k1 Block
    mux2to1 m1 (.a(y2[0]), .b(y2[8]), .sel(k1^left), .y(y1[0]));
    mux2to1 m2 (.a(y2[1]), .b(y2[9]), .sel(k1^left), .y(y1[1]));
    mux2to1 m3 (.a(y2[2]), .b(y2[10]), .sel(k1^left), .y(y1[2]));
    mux2to1 m4 (.a(y2[3]), .b(y2[11]), .sel(k1^left), .y(y1[3]));
    mux2to1 m5 (.a(y2[4]), .b(y2[12]), .sel(k1^left), .y(y1[4]));
    mux2to1 m6 (.a(y2[5]), .b(y2[13]), .sel(k1^left), .y(y1[5]));
    mux2to1 m7 (.a(y2[6]), .b(y2[14]), .sel(k1^left), .y(y1[6]));
    mux2to1 m8 (.a(y2[7]), .b(y2[15]), .sel(k1^left), .y(y1[7]));
    mux2to1 m9 (.a(y2[8]), .b(y2[0]), .sel(k1^left), .y(y1[8]));
    mux2to1 m10 (.a(y2[9]), .b(y2[1]), .sel(k1^left), .y(y1[9]));
    mux2to1 m11 (.a(y2[10]), .b(y2[2]), .sel(k1^left), .y(y1[10]));
    mux2to1 m12 (.a(y2[11]), .b(y2[3]), .sel(k1^left), .y(y1[11]));
    mux2to1 m13 (.a(y2[12]), .b(y2[4]), .sel(k1^left), .y(y1[12]));
    mux2to1 m14 (.a(y2[13]), .b(y2[5]), .sel(k1^left), .y(y1[13]));
    mux2to1 m15 (.a(y2[14]), .b(y2[6]), .sel(k1^left), .y(y1[14]));
    mux2to1 m16 (.a(y2[15]), .b(y2[7]), .sel(k1^left), .y(y1[15]));
 
    //k0 block
    mux2to1 m17 (.a(y1[0]), .b(y1[8]), .sel(k0^left), .y(y[0]));
    mux2to1 m18 (.a(y1[1]), .b(y1[9]), .sel(k0^left), .y(y[1]));
    mux2to1 m19 (.a(y1[2]), .b(y1[10]), .sel(k0^left), .y(y[2]));
    mux2to1 m20 (.a(y1[3]), .b(y1[11]), .sel(k0^left), .y(y[3]));
    mux2to1 m21 (.a(y1[4]), .b(y1[12]), .sel(k0^left), .y(y[4]));
    mux2to1 m22 (.a(y1[5]), .b(y1[13]), .sel(k0^left), .y(y[5]));
    mux2to1 m23 (.a(y1[6]), .b(y1[14]), .sel(k0^left), .y(y[6]));
    mux2to1 m24 (.a(y1[7]), .b(y1[15]), .sel(k0^left), .y(y[7]));
    mux2to1 m25 (.a(y1[8]), .b(y1[0]), .sel(k0^left), .y(y[8]));
    mux2to1 m26 (.a(y1[9]), .b(y1[1]), .sel(k0^left), .y(y[9]));
    mux2to1 m27 (.a(y1[10]), .b(y1[2]), .sel(k0^left), .y(y[10]));
    mux2to1 m28 (.a(y1[11]), .b(y1[3]), .sel(k0^left), .y(y[11]));
    mux2to1 m29 (.a(y1[12]), .b(y1[4]), .sel(k0^left), .y(y[12]));
    mux2to1 m30 (.a(y1[13]), .b(y1[5]), .sel(k0^left), .y(y[13]));
    mux2to1 m31 (.a(y1[14]), .b(y1[6]), .sel(k0^left), .y(y[14]));
    mux2to1 m32 (.a(y1[15]), .b(y1[7]), .sel(k0^left), .y(y[15]));

endmodule


module mux2to1 (
input wire a,b, sel,
output wire y
);

assign y = (sel == 1) ? b : a;

endmodule*/