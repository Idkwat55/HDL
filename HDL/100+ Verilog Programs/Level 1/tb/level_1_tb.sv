//////////////////////////////////////////////////////////////////////////////////
// Risikesvar G 
// GitHub: https://github.com/Idkwat55/HDL/tree/d3b77cc6cf7f21ce3c324b03d73e9c94be3db612/HDL/100%2B%20Verilog%20Programs/Level%201
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////////////////////
// Test Bench for Level 1 Designs


module basic_gates_tb;

    // Declare inputs as registers and output as wire ; from prespective of testbench
    reg a, b, c, d;
    reg [1:0] sel;
    reg [3:0] a4b,b4b;

    reg [3:0] decoder2to4_op;
    reg [7:0] decoder3to8_op;

    reg clk, rst_; // incrementor
    reg flg = 0;
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

    wire  [3:0] count_inc_r ;
    wire gt, lt, eq; // comparator


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
    decoder2to4 u_decoder2to4 (a,b,decoder2to4_op[0],decoder2to4_op[1],decoder2to4_op[2],decoder2to4_op[3]);
    decoder3to8 u_decoder3to8 (a,b,c,decoder3to8_op[0],decoder3to8_op[1],decoder3to8_op[2],decoder3to8_op[3],decoder3to8_op[4],decoder3to8_op[5],decoder3to8_op[6],decoder3to8_op[7]);

    // Incrementor
    incrementor4b u_incrementor4b(.d(d), .clk(clk),.rst_(rst_), .count(count_inc_r));

    // Comparator
    comp4b u_comp4b(.a(a4b), .b(b4b), .gt(gt) , .lt(lt), .eq(eq));

    task expect_bg; //Basic Gates task bg

        input exp_and, exp_or, exp_not, exp_nand, exp_nor, exp_xor, exp_xnor; //Basic Gates

        if (and_out !== exp_and) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT and_ : \t a = %b  b = %b and_out = %b ( expected and_out = %b)",a,b,and_out, exp_and);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (or_out !== exp_or) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT or_ : \t a = %b  b = %b or_out = %b ( expected or_out = %b)",a,b,or_out, exp_or);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (not_out !== exp_not) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT not_ : \t a = %b   not_out = %b ( expected not_out = %b)",a, not_out, exp_not);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (nand_out !== exp_nand) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT nand_ : \t a = %b  b = %b nand_out = %b ( expected nand_out = %b)",a,b,nand_out, exp_nand);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (nor_out !== exp_nor) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT nor_ : \t a = %b  b = %b nor_out = %b ( expected nor_out = %b)",a,b,nor_out, exp_nor);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (xor_out !== exp_xor) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT xor_ : \t a = %b  b = %b xor_out = %b ( expected xor_out = %b)",a,b,xor_out, exp_xor);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (xnor_out !== exp_xnor) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT xnor_ : \t a = %b  b = %b xnor_out = %b ( expected xnor_out = %b)",a,b,xnor_out, exp_xnor);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

    endtask


    task expect_adders; // half, full adder + subtrctor 

        input exp_sumHA, exp_carryHA, exp_sumFA, exp_carryFA, exp_dif, exp_bor;

        if (sum_ha !== exp_sumHA || carry_ha !== exp_carryHA) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT half_adder : \t a = %b  b = %b sum_ha = %b carry_ha = %b ( expected : sum_ha = %b carry_ha = %b)",
                a, b, sum_ha, carry_ha, exp_sumHA, exp_carryHA);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (sum_fa !== exp_sumFA || carry_fa !== exp_carryFA) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT full_adder : \t a = %b  b = %b  c = %b sum_fa = %b carry_fa = %b ( expected : sum_fa = %b carry_fa = %b)",
                a, b, c, sum_fa, carry_fa, exp_sumFA, exp_carryFA);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (diff !== exp_dif || bor !== exp_bor) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT half_subtractor : \t a = %b  b = %b diff = %b bor = %b ( expected : exp_dif = %b exp_bor = %b)",
                a, b, diff, bor, exp_dif, exp_bor);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;


    endtask

    task expect_4bAdder;

        input [3:0] exp_sum;
        input exp_carry;

        if (sum4b_sa !== exp_sum || carry_sa !== exp_carry) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT simple_adder : \t a = %b  b = %b cin = %b sum = %b carry_out = %b ( expected : exp_sumSA = %b exp_carry_SA = %b)",
                a4b, b4b, c, sum4b_sa, carry_sa, exp_sum, exp_carry);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (sum4b_rca !== exp_sum || carry_rca !== exp_carry) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT ripple_adder : \t a = %b  b = %b cin = %b sum = %b carry_out = %b ( expected : exp_sumRCA = %b exp_carry_RCA = %b)",
                a4b, b4b, c, sum4b_rca, carry_rca, exp_sum, exp_carry);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (sum4b_pga !== exp_sum || carry_pga !== exp_carry) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT propagate_adder : \t a = %b  b = %b cin = %b sum = %b carry_out = %b ( expected : exp_sumPGA = %b exp_carry_PGA = %b)",
                a4b, b4b, c, sum4b_pga, carry_pga, exp_sum, exp_carry);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

    endtask

    task expect_mux;

        input exp_y,exp_y4to1;

        if (y !== exp_y) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT mux2to1 : \t a = %b  b = %b sel = %b  y = %b ( expected : exp_y = %b )",
                a, b, sel[0], y, exp_y);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (y_4to1 !== exp_y4to1) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT mux4to1 : \t a = %b  b = %b c = %b d = %b sel = %b  y = %b ( expected : exp_y4to1 = %b )",
                a, b, c, d, sel, y, exp_y);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

    endtask

    task expect_decoder;
        input [3:0] exp_a2bit;
        input [7:0]  exp_a4bit;
        // a2b1 - var 'a' of '2' bits, suffix 1
        if (decoder2to4_op !== exp_a2bit) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT decoder2to4 : \t a = %b  b = %b  {q3,q2,q1,q0} = %b ( expected : {q3,q2,q1,q0} = %b )",
                a, b, decoder2to4_op, exp_a2bit);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

        if (decoder3to8_op !== exp_a4bit ) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT decoder3to8 : \t a = %b  b = %b c = %b {q7,q6,q5,q4,q3,q2,q1,q0}= %b ( expected : {q7,q6,q5,q4,q3,q2,q1,q0} = %b )",
                a, b, c, decoder3to8_op, exp_a4bit);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else t_cases = t_cases+1;

    endtask

    task expect_incrementor ;
        input [3:0] exp_count;

        if (count_inc_r !== exp_count ) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT incrementor4b : \t d = %b clk = %b  rst_ = %b  count = %b ( expected : count = %b )",
                d, clk, rst_, count_inc_r, exp_count);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else begin
            t_cases = t_cases+1;
        end
    endtask

    task expect_copm;
        input [2:0] exp_gle;
        if ({gt,lt,eq} !== exp_gle ) begin
            $display(" TEST FAILED  @ %t", $realtime);
            $display("\t UUT Comparator (4-bit) : \t a = %b b = %b  gt = %b  lt = %b eq = %b ( expected :  gt = %b  lt = %b eq = %b )",
                a, b, gt, lt,eq, exp_gle[2], exp_gle[1], exp_gle[0]);
            $display(" Total Test cases completed : %d",t_cases);
            $stop;
        end else begin
            t_cases = t_cases+1;
        end
    endtask




    initial begin : mainBlock
        $timeformat(-9, 2, " ns", 10);
        $display("\n\nRunning: TestBench for Level 1 Designs ");

        $display(" Testing: Basic Gates ");
        {a,b} = 2'b00; #1 expect_bg (0,0,1,1,1,0,1);
        {a,b} = 2'b01; #1 expect_bg (0,1,1,1,0,1,0);
        {a,b} = 2'b10; #1 expect_bg (0,1,0,1,0,1,0);
        {a,b} = 2'b11; #1 expect_bg (1,1,0,0,0,0,1);
        $display("\t-- Ok! ");

        $display(" Testing: Half, Full Adders and Half Subtractor ");
        {a,b,c} = 3'b000; #1 expect_adders (0,0,0,0,0,0);
        {a,b,c} = 3'b010; #1 expect_adders (1,0,1,0,1,1);
        {a,b,c} = 3'b100; #1 expect_adders (1,0,1,0,1,0);
        {a,b,c} = 3'b110; #1 expect_adders (0,1,0,1,0,0);
        {a,b,c} = 3'b001; #1 expect_adders (0,0,1,0,0,0);
        {a,b,c} = 3'b011; #1 expect_adders (1,0,0,1,1,1);
        {a,b,c} = 3'b101; #1 expect_adders (1,0,0,1,1,0);
        {a,b,c} = 3'b111; #1 expect_adders (0,1,1,1,0,0);
        $display("\t-- Ok! ");

        $display(" Testing: 4bit Adders ");
        for (i = 0; i<16; i = i+1) begin
            for (j = 0; j<16; j = j+1) begin
                a4b = i; b4b = j; c= 0;
                {tmp_carry,tmp_sum} = a4b + b4b + c;
                #1 expect_4bAdder (tmp_sum, tmp_carry);
                // {tmp_carry,tmp_sum} = 5'b00000; #1;  //To reduce time
                a4b = i; b4b = j; c= 1;
                {tmp_carry,tmp_sum} = a4b + b4b + c;
                #1 expect_4bAdder (tmp_sum, tmp_carry);
            end
        end
        $display("\t-- Ok! ");

        $display(" Testing: 2:1 Mux & 4:1 Mux");
        //ab_cd_sel[1]sel[0]     mux2to1 , mux4to1
        {a,b,c,d,sel} = 6'b000_000;
        for (i = 0; i < 64; i = i + 1) begin
            {a,b,c,d,sel} =  {a,b,c,d,sel} + 1; # 1 expect_mux ( (sel[0] == 0) ? a : b  ,
                ( sel == 2'b00 ) ? a
                : ( sel == 2'b01 ) ? b
                : ( sel == 2'b10 ) ? c
                : ( sel == 2'b11 ) ? d
                : 1'bx);
        end
        $display("\t-- Ok! ");

        $display(" Testing: 2:4 Decoder & 3:8 Decoder");
        //              input   -> output
        // 2:4 decoder -  a, b  -> decoder2to4_op
        // 3:8 decoder   a,b,c  -> decoder3to8_op
        {a,b,c} = 3'b000; #1;
        for (i = 0; i<8; i = i+1) begin
            {a,b,c} = {a,b,c} + 1; #1 expect_decoder( 4'b001 << {a,b}, 8'b0000_0001 << {a,b,c});
        end
        $display("\t-- Ok! ");

        $display(" Testing: Incrementor");

        d = 1; clk = 0; rst_ = 0; #2; // Hold reset for longer
        rst_ = 1; #1; // Release reset
        i = 0;
        while (i < 16)  begin
            clk = ~clk; #1;
            expect_incrementor(i + 1); // Check output right at posedge clk
            clk = ~clk; #1;
            i = i + 1;
        end
        rst_ = 0; #1; // Hold reset
        expect_incrementor(0); // Check output right at posedge clk
        $display("\t-- Ok! ");

        $display(" Testing: Comparator");
        {a4b,b4b} = 2'b00; #1;
        for (i = 0; i < 8; i = i + 1) begin
            {a4b,b4b} = {a4b,b4b} + 1; #1;
            expect_copm( (a4b > b4b) ? 3'b1zz : (a4b < b4b) ? 3'bz1z : (a4b === b4b) ? 3'bzz1 : 3'bzzz );
        end
        $display("\t-- Ok! ");

        $display("\n ALL TESTS PASSED! ");
        $display(" Total test cases : %d",t_cases);
        $display(" Time Taken : %t\n",$realtime);
        $finish;
    end

endmodule
