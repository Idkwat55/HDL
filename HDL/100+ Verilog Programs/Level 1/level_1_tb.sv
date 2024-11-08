`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////
// Test Bench for Level 1 Designs


module basic_gates_tb;

// Declare inputs as registers and output as wire
reg a, b, c, d;
reg [1:0] sel;
reg [3:0] a4b,b4b;


reg [3:0] tmp_sum, tmp_a4b, tmp_b4b;
reg tmp_carry;
reg [31:0] t_cases = 0; 

reg [31:0] i,j;

// Declare test variables for each gate output
wire and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out; // Basic Gates
wire sum_ha, carry_ha, sum_fa, carry_fa, diff, bor; //Half and full adder , half subtractor
wire [3:0] sum4b_sa, sum4b_rca, sum4b_pga;
wire carry_sa, carry_rca, carry_pga; 
wire y,y_4to1; // mux

    // Instantiate the gate modules
    
    //Basic Gates
    and_ u_and (.c(and_out), .a(a), .b(b));
    or_  u_or  (.c(or_out),  .a(a), .b(b));
    not_ u_not (.c(not_out), .a(a));
    nand_ u_nand (.c(nand_out), .a(a), .b(b));
    nor_  u_nor  (.c(nor_out),  .a(a), .b(b));
    xor_  u_xor  (.c(xor_out),  .a(a), .b(b));
    xnor_  u_xnor  (.c(xnor_out),  .a(a), .b(b));
    
    //   Adders + Subtractors
    half_adder u_ha (.a(a),.b(b),.sum(sum_ha),.carry(carry_ha));
    full_adder u_fa (.a(a),.b(b),.c(c), .sum(sum_fa),.carry(carry_fa));
    half_subtractor u_hs (.a(a), .b(b), .difference(diff), .borrow(bor));
    simple_adder u_simple_adder (.a(a4b), .b(b4b), .carry_in(c), .sum(sum4b_sa), .carry(carry_sa) );
    ripple_adder u_ripple (a4b, b4b, c, sum4b_rca, carry_rca);
    propagate_adder u_pga (.a(a4b), .b(b4b), .cin(c), .sum(sum4b_pga), .carry(carry_pga));
    
    // mux
    mux2to1 u_mux2to1 (.y(y), .a(a), .b(b), .sel(sel[0])); 
    mux4to1 u_mux4to1 (.y(y_4to1),.a(a), .b(b), .c(c), .d(d), .sel(sel));
    
    // Decoder
  /*  decoder2to4 u_decoder2to4 (a,b,a4b[0],a4b[1],a4b[2],a4b[3]);
    decoder3to8 u_decoder3to8 (a,b,c,d,a4b[0],a4b[1],a4b[2],a4b[3],b4b[0],b4b[1],b4b[2],b4b[3]);*/


task expect_bg;  //Basic Gates task bg

input exp_and, exp_or, exp_not, exp_nand, exp_nor, exp_xor, exp_xnor; //Basic Gates

    if (and_out !== exp_and) begin
        $display(" TEST FAILED ");
        $display("\t UUT and_ : \t a = %b  b = %b and_out = %b ( expected and_out = %b)",a,b,and_out, exp_and);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (or_out !== exp_or) begin
        $display(" TEST FAILED ");
        $display("\t UUT or_ : \t a = %b  b = %b or_out = %b ( expected or_out = %b)",a,b,or_out, exp_or);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (not_out !== exp_not) begin
        $display(" TEST FAILED ");
        $display("\t UUT not_ : \t a = %b   not_out = %b ( expected not_out = %b)",a, not_out, exp_not);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (nand_out !== exp_nand) begin
        $display(" TEST FAILED ");
        $display("\t UUT nand_ : \t a = %b  b = %b nand_out = %b ( expected nand_out = %b)",a,b,nand_out, exp_nand);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (nor_out !== exp_nor) begin
        $display(" TEST FAILED ");
        $display("\t UUT nor_ : \t a = %b  b = %b nor_out = %b ( expected nor_out = %b)",a,b,nor_out, exp_nor);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (xor_out !== exp_xor) begin
        $display(" TEST FAILED ");
        $display("\t UUT xor_ : \t a = %b  b = %b xor_out = %b ( expected xor_out = %b)",a,b,xor_out, exp_xor);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (xnor_out !== exp_xnor) begin
        $display(" TEST FAILED ");
        $display("\t UUT xnor_ : \t a = %b  b = %b xnor_out = %b ( expected xnor_out = %b)",a,b,xnor_out, exp_xnor);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
endtask


task expect_adders; // half, full adder + subtrctor 

input exp_sumHA, exp_carryHA, exp_sumFA, exp_carryFA, exp_dif, exp_bor;

    if (sum_ha !== exp_sumHA || carry_ha !== exp_carryHA) begin
        $display(" TEST FAILED ");
        $display("\t UUT half_adder : \t a = %b  b = %b sum_ha = %b carry_ha = %b ( expected : sum_ha = %b carry_ha = %b)", 
        a, b, sum_ha, carry_ha, exp_sumHA, exp_carryHA);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (sum_fa !== exp_sumFA || carry_fa !== exp_carryFA) begin
        $display(" TEST FAILED ");
        $display("\t UUT full_adder : \t a = %b  b = %b  c = %b sum_fa = %b carry_fa = %b ( expected : sum_fa = %b carry_fa = %b)", 
        a, b, c, sum_fa, carry_fa, exp_sumFA, exp_carryFA);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (diff !== exp_dif || bor !== exp_bor) begin
        $display(" TEST FAILED ");
        $display("\t UUT half_subtractor : \t a = %b  b = %b diff = %b bor = %b ( expected : exp_dif = %b exp_bor = %b)", 
        a, b, diff, bor, exp_dif, exp_bor);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;


endtask

task expect_4bAdder;

input [3:0] exp_sum;
input exp_carry;
   
    if (sum4b_sa !== exp_sum || carry_sa !== exp_carry) begin
        $display(" TEST FAILED ");
        $display("\t UUT simple_adder : \t a = %b  b = %b cin = %b sum = %b carry_out = %b ( expected : exp_sumSA = %b exp_carry_SA = %b)", 
        a4b, b4b, c, sum4b_sa, carry_sa, exp_sum, exp_carry);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (sum4b_rca !== exp_sum || carry_rca !== exp_carry) begin
        $display(" TEST FAILED ");
        $display("\t UUT ripple_adder : \t a = %b  b = %b cin = %b sum = %b carry_out = %b ( expected : exp_sumRCA = %b exp_carry_RCA = %b)", 
        a4b, b4b, c, sum4b_rca, carry_rca, exp_sum, exp_carry);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (sum4b_pga !== exp_sum || carry_pga !== exp_carry) begin
        $display(" TEST FAILED ");
        $display("\t UUT propagate_adder : \t a = %b  b = %b cin = %b sum = %b carry_out = %b ( expected : exp_sumPGA = %b exp_carry_PGA = %b)", 
        a4b, b4b, c, sum4b_pga, carry_pga, exp_sum, exp_carry);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
endtask

task expect_mux;

input exp_y,exp_y4to1;

    if (y !== exp_y) begin
        $display(" TEST FAILED ");
        $display("\t UUT mux2to1 : \t a = %b  b = %b sel = %b  y = %b ( expected : exp_y = %b )", 
        a, b, sel[0], y, exp_y);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (y_4to1 !== exp_y4to1) begin
        $display(" TEST FAILED ");
        $display("\t UUT mux4to1 : \t a = %b  b = %b c = %b d = %b sel = %b  y = %b ( expected : exp_y4to1 = %b )", 
        a, b, c, d, sel, y, exp_y);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;

endtask
/*
task expect_decoder;

input [3:0] expa4b1, exp_a4b,exp_b4b;

    if (a4b1 !== exp_a4b1) begin
        $display(" TEST FAILED ");
        $display("\t UUT decoder2to1 : \t a = %b  b = %b  {q3,q2,q1,q0} = %b ( expected : {q3,q2,q1,q0} = %b )", 
        a, b, a4b, exp_a4b1);
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;
    
    if (a4b !== exp_a4b || b4b !== exp_b4b) begin
        $display(" TEST FAILED ");
        $display("\t UUT decoder3to8 : \t a = %b  b = %b c = %b d = %b {q7,q6,q5,q4,q3,q2,q1,q0}= %b ( expected : {q7,q6,q5,q4,q3,q2,q1,q0} = %b )", 
        a, b, c, d, {a4b, b4b}, {exp_a4b,b4b});
        $display(" Total Test cases completed : %d",t_cases);
        $finish;
    end else t_cases = t_cases+1;

endtask*/



initial begin
    $display("\n\nRunning: TestBench for Level 1 Designs ");
    
    $display(" Testing: Basic Gates");
        {a,b} = 2'b00; #1 expect_bg (0,0,1,1,1,0,1);
        {a,b} = 2'b01; #1 expect_bg (0,1,1,1,0,1,0);
        {a,b} = 2'b10; #1 expect_bg (0,1,0,1,0,1,0);
        {a,b} = 2'b11; #1 expect_bg (1,1,0,0,0,0,1);
    $display("\t--  Basic Gates Passed ");
    
    $display(" Testing: Half, Full Adders and Half Subtractor ");
        {a,b,c} = 3'b000; #1 expect_adders (0,0,0,0,0,0);
        {a,b,c} = 3'b010; #1 expect_adders (1,0,1,0,1,1);
        {a,b,c} = 3'b100; #1 expect_adders (1,0,1,0,1,0);
        {a,b,c} = 3'b110; #1 expect_adders (0,1,0,1,0,0);
        {a,b,c} = 3'b001; #1 expect_adders (0,0,1,0,0,0);
        {a,b,c} = 3'b011; #1 expect_adders (1,0,0,1,1,1);
        {a,b,c} = 3'b101; #1 expect_adders (1,0,0,1,1,0);
        {a,b,c} = 3'b111; #1 expect_adders (0,1,1,1,0,0);
    $display("\t--  Half, Full Adders and Half Subtractor Passed ");
    
    $display(" Testing: 4bit Adders ");
    for (i = 0; i<16; i = i+1) begin
        for (j = 0; j<16; j = j+1) begin
            a4b = i; b4b = j; c= 0;
            {tmp_carry,tmp_sum} = a4b+b4b+c;
            #1 expect_4bAdder (tmp_sum, tmp_carry);
          // {tmp_carry,tmp_sum} = 5'b00000; #1;  //To reduce time
            a4b = i; b4b = j; c= 1;
            {tmp_carry,tmp_sum} = a4b+b4b+c;
            #1 expect_4bAdder (tmp_sum, tmp_carry);
        end
    end 
    $display("\t-- 4bit Adders Passed ");
    
    $display(" Testing: 2:1 Mux & 4:1 Mux");
                         //ab_cd_sel[1]sel[0]     mux2to1 , mux4to1
        {a,b,c,d,sel} = 6'b00_00_00; #1 expect_mux (0,0);
        {a,b,c,d,sel} = 6'b10_00_00; #1 expect_mux (1,1);
        {a,b,c,d,sel} = 6'b00_00_01; #1 expect_mux (0,0);
        {a,b,c,d,sel} = 6'b01_00_01; #1 expect_mux (1,1);
        {a,b,c,d,sel} = 6'b00_10_10; #1 expect_mux (0,1);
        {a,b,c,d,sel} = 6'b00_01_11; #1 expect_mux (0,1);
    $display("\t-- 2:1 Mux & 4:1 Mux Passed");
    
   /* {a,b,c,d} = 4'b0000;
    tmp_a4b
     #1 expect_decoder (tmp_a4b,tmp_b4b);
    */
    
    $display("###### Decoders, Comparator, Incrementor, Priority Encoders are not Included in this testbench!!! ######");
    $display("\n ALL TESTS PASSED! ");
    $display(" Total test cases : %d",t_cases);
    $display(" Time Taken : %t ps\n",$realtime);
    $stop;
end

endmodule
