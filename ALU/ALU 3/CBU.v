module CBU(out, in, a, b, rst, clk);
    //CBU with 3 4-bit registers and an 8 function, 4-bit ALU

    //Instructions take the following form:  [1][2][3][4]
    //[1] is 3 bits, [8:6], and indicates the ALU function.
    //[2] is 2 bits, [5:4], and indicates the register address for input a.
    //[3] is 2 bits, [3:2], and indicates the register address for input b.
    //[4] is 2 bits, [1:0], and indicates the register address for the ALU output.

    //Inputs, [2] and [3], should not have the same register address.

    //Due to clock cycle delays, next inputs, [2] and [3], should not have the
    //same register address as the previous instruction's output, [4].

    //See ALU description for list of ALU function codes.


    output [3:0] out;
    input [8:0] in;
    input [3:0] a, b;
    input rst, clk;
    wire [8:0] w_in_reg_out;
    wire [3:0] w_in1, w_in2, w_out, w_reg01, w_reg10, w_reg11;
    wire [2:0] w_s_ALU;
    wire [1:0] w_s_in1, w_s_in2, w_s_reg_in1, w_s_reg_in2, w_s_out, w_reg_s_out;

    //Set selector wires for reg inputs
    assign w_s_in1 = in[5:4];
    assign w_s_in2 = in[3:2];
    assign w_s_out = w_in_reg_out[1:0];

    //Queue a, b, out, and instruction to the appropriate registers for loading
    //Register needs to load next inputs and previous output simultaneously
    Register Register_00(w_reg01, w_reg10, w_reg11, a, b, w_out, w_s_in1, w_s_in2, w_s_out, rst, clk);
    reg_9b reg_9b_in(w_in_reg_out, in, rst, clk);

    //Set selector wires for ALU inputs
    assign w_s_reg_in1 = w_in_reg_out[5:4];
    assign w_s_reg_in2 = w_in_reg_out[3:2];

    //Select appropriate register outputs to use as ALU inputs
    mux_4x1_4b mux_4x1_4b_in1(w_in1, 4'b0000, w_reg01, w_reg10, w_reg11, w_s_reg_in1);
    mux_4x1_4b mux_4x1_4b_in2(w_in2, 4'b0000, w_reg01, w_reg10, w_reg11, w_s_reg_in2);

    //Send loaded inputs and selector to the ALU
    assign w_s_ALU = w_in_reg_out[8:6];
    ALU ALU_00(w_out, w_in1, w_in2, w_s_ALU, rst, clk);

    //Load the output selector to a register
    //This prevents the selector from being overwritten at the moment
    //the output and next instruction are loaded to the registers
    reg_2b reg_2b_s_out(w_reg_s_out, w_s_out, rst, clk);

    //Set the output
    mux_4x1_4b mux_4x1_4b_out(out, 4'b0000, w_reg01, w_reg10, w_reg11, w_reg_s_out);

endmodule

module ALU(out, in1, in2, s, rst, clk);
    //8 function, 4-bit ALU

    //s = 000:  Adder
    //s = 001:  Subtractor
    //s = 010:  Incrementor
    //s = 011:  Decrementor
    //s = 100:  Comparator
    //s = 101:  Up-counter
    //s = 110:  Down-counter
    //s = 111:  2x Multiplier


    output [3:0] out;
    input [3:0] in1, in2;
    input [2:0] s;
    input rst, clk;
    wire [3:0] w_add, w_sub, w_inc, w_dec, w_comp, w_up, w_down, w_mult;
    wire w_up_cnt, w_down_cnt, unused;

    //Set counter cnt wires if they are the selected function
    assign w_up_cnt = s[2] && ~s[1] && s[0];
    assign w_down_cnt = s[2] && s[1] && ~s[0];

    //Registers can hold 8 bits, but these components only process the last 4 bits
    adder_4b adder_4b_00(w_add, unused, in1, in2, 1'b0);
    subtractor_4b subtractor_4b_00(w_sub, unused, in1, in2);
    incrementor_4b incrementor_4b_00(w_inc, unused, in1);
    decrementor_4b decrementor_4b_00(w_dec, unused, in1);
    comparator_4b comparator_4b_00(w_comp, unused, in1, in2);
    up_counter_4b up_counter_4b_00(w_up, unused, w_up_cnt, clk, rst);
    down_counter_4b down_counter_4b_00(w_down, unused, w_down_cnt, clk, rst);
    left_shifter_x1_4b left_shifter_x1_4b_00(w_mult, unused, in1, 1'b0, 1'b1);

    //Pass the out from the selected function into the output variable
    mux_8x1_4b mux_8x1_4b_00(out, w_add, w_sub, w_inc, w_dec, w_comp, w_up, w_down, w_mult, s);

endmodule

module Register(out01, out10, out11, in1, in2, in3, s1, s2, s3, rst, clk);
    //ALU Register Block

    //If any selector is set to 2'b00, that input is not loaded to any register.
    //Register Block always outputs the values held in all 3 registers.


    output [3:0] out01, out10, out11;
    input [3:0] in1, in2, in3;
    input [1:0] s1, s2, s3;
    input rst, clk;
    wire [3:0] w_in_01, w_in_10, w_in_11;
    wire w_ld_01, w_ld_10, w_ld_11;

    //Set wires to determine which registers, if any, should be written to.
    assign w_ld_01 = (~s1[1] && s1[0]) || (~s2[1] && s2[0]) || (~s3[1] && s3[0]);
    assign w_ld_10 = (s1[1] && ~s1[0]) || (s2[1] && ~s2[0]) || (s3[1] && ~s3[0]);
    assign w_ld_11 = (s1[1] && s1[0]) || (s2[1] && s2[0]) || (s3[1] && s3[0]);

    //Determine which inputs should be loaded to which registers.
    assign w_in_01[0] = (~s1[1] && s1[0] && in1[0]) || (~s2[1] && s2[0] && in2[0]) || (~s3[1] && s3[0] && in3[0]);
    assign w_in_01[1] = (~s1[1] && s1[0] && in1[1]) || (~s2[1] && s2[0] && in2[1]) || (~s3[1] && s3[0] && in3[1]);
    assign w_in_01[2] = (~s1[1] && s1[0] && in1[2]) || (~s2[1] && s2[0] && in2[2]) || (~s3[1] && s3[0] && in3[2]);
    assign w_in_01[3] = (~s1[1] && s1[0] && in1[3]) || (~s2[1] && s2[0] && in2[3]) || (~s3[1] && s3[0] && in3[3]);
    assign w_in_10[0] = (s1[1] && ~s1[0] && in1[0]) || (s2[1] && ~s2[0] && in2[0]) || (s3[1] && ~s3[0] && in3[0]);
    assign w_in_10[1] = (s1[1] && ~s1[0] && in1[1]) || (s2[1] && ~s2[0] && in2[1]) || (s3[1] && ~s3[0] && in3[1]);
    assign w_in_10[2] = (s1[1] && ~s1[0] && in1[2]) || (s2[1] && ~s2[0] && in2[2]) || (s3[1] && ~s3[0] && in3[2]);
    assign w_in_10[3] = (s1[1] && ~s1[0] && in1[3]) || (s2[1] && ~s2[0] && in2[3]) || (s3[1] && ~s3[0] && in3[3]);
    assign w_in_11[0] = (s1[1] && s1[0] && in1[0]) || (s2[1] && s2[0] && in2[0]) || (s3[1] && s3[0] && in3[0]);
    assign w_in_11[1] = (s1[1] && s1[0] && in1[1]) || (s2[1] && s2[0] && in2[1]) || (s3[1] && s3[0] && in3[1]);
    assign w_in_11[2] = (s1[1] && s1[0] && in1[2]) || (s2[1] && s2[0] && in2[2]) || (s3[1] && s3[0] && in3[2]);
    assign w_in_11[3] = (s1[1] && s1[0] && in1[3]) || (s2[1] && s2[0] && in2[3]) || (s3[1] && s3[0] && in3[3]);

    //Set input and get output from each register
    load_reg_4b load_reg_4b_01(out01, w_in_01, w_ld_01, rst, clk);
    load_reg_4b load_reg_4b_10(out10, w_in_10, w_ld_10, rst, clk);
    load_reg_4b load_reg_4b_11(out11, w_in_11, w_ld_11, rst, clk);

endmodule

module subtractor_4b(out, cout, num1, num2);
    //4 bit subtractor
    output [3:0] out;
    output cout;
    input [3:0] num1;
    input [3:0] num2;
    wire [3:0] num2_neg;
    wire unused;

    assign num2_neg[0] = ~num2[0];
    assign num2_neg[1] = ~num2[1];
    assign num2_neg[2] = ~num2[2];
    assign num2_neg[3] = ~num2[3];

    adder_4b adder_4b_s(out, unused, num1, num2_neg, 1'b1);
    
    //Conform output to standards
    assign cout = 0;

endmodule

module adder_4b(out, cout, num1, num2, cin);
    //4 bit Adder with cin
    output [3:0] out;
    output cout;
    input [3:0] num1;
    input [3:0] num2;
    input cin;
    wire c1, c2, c3;

    full_adder full_adder_01(out[0], c1, num1[0], num2[0], cin);
    full_adder full_adder_02(out[1], c2, num1[1], num2[1], c1);
    full_adder full_adder_03(out[2], c3, num1[2], num2[2], c2);
    full_adder full_adder_04(out[3], cout, num1[3], num2[3], c3);
endmodule

module full_adder(a, cout, i1, i2, cin);
    //Full Adder
    output a, cout;
    input i1, i2, cin;
    wire w_a1, w_c1, w_c2;

    half_adder half_adder_01(w_a1, w_c1, i1, i2);
    half_adder half_adder_02(a, w_c2, cin, w_a1);

    assign cout = w_c1 || w_c2;
endmodule

module half_adder(a, c, i1, i2);
    //Half-Adder
    output a, c;
    input i1, i2;

    //EDA Playground didn't like xor
    //assign a = i1 xor i2;
    assign a = (i1 && ~i2) || (~i1 && i2);
    assign c = i1 && i2;
endmodule

module incrementor_4b(out, cout, num);
    //4 bit Incrementor
    output [3:0] out;
    output cout; //Indicates overflow
    input [3:0] num;
    wire w_c0, w_c1, w_c2;

    half_adder half_adder_0(out[0], w_c0, num[0], 1'b1);
    half_adder half_adder_1(out[1], w_c1, num[1], w_c0);
    half_adder half_adder_2(out[2], w_c2, num[2], w_c1);
    half_adder half_adder_3(out[3], cout, num[3], w_c2);

endmodule

module decrementor_4b(out, cout, num);
    //4 bit Decrementor
    output [3:0] out;
    output cout;
    input [3:0] num;
    wire w_b0, w_b1, w_b2, unused;

    half_subtractor half_subtractor_00(out[0], w_b0, num[0], 1'b1);
    half_subtractor half_subtractor_01(out[1], w_b1, num[1], w_b0);
    half_subtractor half_subtractor_02(out[2], w_b2, num[2], w_b1);
    half_subtractor half_subtractor_03(out[3], unused, num[3], w_b2);

    //Conform output to standards
    assign cout = 0;

endmodule

module half_subtractor(out, bout, in1, in2);
    //Half-subtractor
    output out, bout;
    input in1, in2;

    assign out = (in1 && ~in2) || (~in1 && in2);
    assign bout = ~in1 && in2;

endmodule

module comparator_4b(out, cout, num1, num2);
    //4 bit comparator
    output [3:0] out;
    output cout;
    input [3:0] num1, num2;
    wire w_gt03, w_gt02, w_gt01, w_lt03, w_lt02, w_lt01, w_eq03, w_eq02, w_eq01;

    comparator comparator03(w_gt03, w_lt03, w_eq03, num1[3], num2[3], 1'b0, 1'b0, 1'b1);
    comparator comparator02(w_gt02, w_lt02, w_eq02, num1[2], num2[2], w_gt03, w_lt03, w_eq03);
    comparator comparator01(w_gt01, w_lt01, w_eq01, num1[1], num2[1], w_gt02, w_lt02, w_eq02);
    comparator comparator00(out[2], out[1], out[0], num1[0], num2[0], w_gt01, w_lt01, w_eq01);

    //Conform output to standards
    assign out[3] = 0;
    assign cout = 0;

endmodule

module comparator(gto, lto, eqo, num1, num2, gti, lti, eqi);
    //Comparator
    output gto, lto, eqo;
    input num1, num2, gti, lti, eqi;

    assign gto = gti || (eqi && num1 && ~num2);
    assign lto = lti || (eqi && ~num1 && num2);
    assign eqo = eqi && ((num1 && num2) || (~num1 && ~num2));
    
endmodule

module up_counter_4b(count, tcount, cnt, clk, rst);
    //4-bit Up-Counter
    output [3:0] count;
    output tcount;
    input cnt, clk, rst;
    wire [3:0] w_inc_out;
    wire unused;

    //Store value and determine outputs
    load_reg_4b load_reg_4b_00(count, w_inc_out, cnt, rst, clk);
    assign tcount = count[0] && count[1] && count[2] && count[3];

    //Increment count
    incrementor_4b incrementor_4b_00(w_inc_out, unused, count);

endmodule

module down_counter_4b(count, tcount, cnt, clk, rst);
    //4-bit Down-Counter
    output [3:0] count;
    output tcount;
    input cnt, clk, rst;
    wire [3:0] w_dec_out;
    wire unused;

    //Store value and determine outputs
    load_reg_4b load_reg_4b_00(count, w_dec_out, cnt, rst, clk);
    assign tcount = ~(count[0] || count[1] || count[2] || count[3]);

    //Decrement count
    decrementor_4b decrementor_4b_00(w_dec_out, unused, count);

endmodule

module mux_2x1_4b(out, i0, i1, s);
    //4-bit 2x1 Mux
    output [3:0] out;
    input [3:0] i0, i1;
    input s;

    mux_2x1 mux_2x1_00(out[0], i0[0], i1[0], s);
    mux_2x1 mux_2x1_01(out[1], i0[1], i1[1], s);
    mux_2x1 mux_2x1_10(out[2], i0[2], i1[2], s);
    mux_2x1 mux_2x1_11(out[3], i0[3], i1[3], s);

endmodule

module mux_2x1(out, i0, i1, s);
    //1-bit 2x1 Mux
    output out;
    input i0, i1, s;

    assign out = (~s && i0) || (s && i1);
    
endmodule

module left_shifter_x1_4b(out, cout, in, cin, sh);
    //4-bit 1 x Left Shifter
    output [3:0] out;
    output cout;
    input [3:0] in;
    input cin, sh;

    mux_2x1 mux_2x1_00(out[0], in[0], cin, sh);
    mux_2x1 mux_2x1_01(out[1], in[1], in[0], sh);
    mux_2x1 mux_2x1_02(out[2], in[2], in[1], sh);
    mux_2x1 mux_2x1_03(out[3], in[3], in[2], sh);
    assign cout = sh && in[3];

endmodule

module load_reg_4b(out, in, ld, rst, clk);
    //4-bit Load Register
    output [3:0] out;
    input [3:0] in;
    input ld, rst, clk;

    load_reg load_reg_00(out[0], in[0], ld, rst, clk);
    load_reg load_reg_01(out[1], in[1], ld, rst, clk);
    load_reg load_reg_02(out[2], in[2], ld, rst, clk);
    load_reg load_reg_03(out[3], in[3], ld, rst, clk);

endmodule

module load_reg(out, in, ld, rst, clk);
    //1-bit Load Register
    output out;
    input in, ld, rst, clk;
    wire w_mux_out, w_out;

    assign w_out = out;
    mux_2x1 mux_2x1_00(w_mux_out, w_out, in, ld);
    D_FF D_FF_00(out, w_mux_out, rst, clk);
    
endmodule

module D_FF(q, d, rst, clk);
    output q;
    input d, rst, clk;
    reg q;

    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule

module mux_4x1_4b(out, i0, i1, i2, i3, s);
    //4-bit 4x1 Mux
    output [3:0] out;
    input [3:0] i0, i1, i2, i3;
    input [1:0] s;

    mux_4x1 mux_4x1_00(out[0], i0[0], i1[0], i2[0], i3[0], s);
    mux_4x1 mux_4x1_01(out[1], i0[1], i1[1], i2[1], i3[1], s);
    mux_4x1 mux_4x1_10(out[2], i0[2], i1[2], i2[2], i3[2], s);
    mux_4x1 mux_4x1_11(out[3], i0[3], i1[3], i2[3], i3[3], s);

endmodule

module mux_4x1(out, i0, i1, i2, i3, s);
    //1-bit 4x1 Mux
    output out;
    input i0, i1, i2, i3;
    input [1:0] s;

    assign out = (~s[1] && ~s[0] && i0) || (~s[1] && s[0] && i1) || (s[1] && ~s[0] && i2) || (s[1] && s[0] && i3);
    
endmodule

module reg_9b(out, in, rst, clk);
    output [8:0] out;
    input [8:0] in;
    input rst, clk;

    D_FF D_Reg00(out[0], in[0], rst, clk);
    D_FF D_Reg01(out[1], in[1], rst, clk);
    D_FF D_Reg02(out[2], in[2], rst, clk);
    D_FF D_Reg03(out[3], in[3], rst, clk);
    D_FF D_Reg04(out[4], in[4], rst, clk);
    D_FF D_Reg05(out[5], in[5], rst, clk);
    D_FF D_Reg06(out[6], in[6], rst, clk);
    D_FF D_Reg07(out[7], in[7], rst, clk);
    D_FF D_Reg08(out[8], in[8], rst, clk);

endmodule

module reg_2b(out, in, rst, clk);
    output [1:0] out;
    input [1:0] in;
    input rst, clk;

    D_FF D_Reg00(out[0], in[0], rst, clk);
    D_FF D_Reg01(out[1], in[1], rst, clk);

endmodule

module mux_8x1_4b(out, i0, i1, i2, i3, i4, i5, i6, i7, s);
    //8-bit 4x1 Mux
    output [3:0] out;
    input [3:0] i0, i1, i2, i3, i4, i5, i6, i7;
    input [2:0] s;

    mux_8x1 mux_8x1_00(out[0], i0[0], i1[0], i2[0], i3[0], i4[0], i5[0], i6[0], i7[0], s);
    mux_8x1 mux_8x1_01(out[1], i0[1], i1[1], i2[1], i3[1], i4[1], i5[1], i6[1], i7[1], s);
    mux_8x1 mux_8x1_10(out[2], i0[2], i1[2], i2[2], i3[2], i4[2], i5[2], i6[2], i7[2], s);
    mux_8x1 mux_8x1_11(out[3], i0[3], i1[3], i2[3], i3[3], i4[3], i5[3], i6[3], i7[3], s);

endmodule

module mux_8x1(out, i0, i1, i2, i3, i4, i5, i6, i7, s);
    //1-bit 8x1 Mux
    output out;
    input i0, i1, i2, i3, i4, i5, i6, i7;
    input [2:0] s;

    assign out = (~s[2] && ~s[1] && ~s[0] && i0) || (~s[2] && ~s[1] && s[0] && i1) || (~s[2] && s[1] && ~s[0] && i2) || (~s[2] && s[1] && s[0] && i3) || (s[2] && ~s[1] && ~s[0] && i4) || (s[2] && ~s[1] && s[0] && i5) || (s[2] && s[1] && ~s[0] && i6) || (s[2] && s[1] && s[0] && i7);
    
endmodule