`include "Adder_Subtractor.v"
`include "Incrementor.v"
`include "Decrementor.v"
`include "Comparator_4b.v"
`include "Up-Counter_4b.v"
`include "Down-Counter_4b.v"
`include "Left_Shifter_x1_4b.v"
`include "Mux_8x1_4b.v"
`include "Load_Reg.v"
module ALU(out, in1, in2, s, ld, rst, clk);
    //8 function, 4-bit ALU
    //s = 000:  Adder
    //s = 001:  Subtractor
    //s = 010:  Incrementor
    //s = 011:  Decrementor
    //s = 100:  Comparator
    //s = 101:  Up-counter
    //s = 110:  Down-counter
    //s = 111:  2x Multiplier
    output [7:0] out;
    input [3:0] in1, in2;
    input [2:0] s;
    input ld, rst, clk;
    wire [7:0] w_in1, w_in2, w_reg1, w_reg2, w_pre_out, unused;
    wire [3:0] w_add, w_sub, w_inc, w_dec, w_comp, w_up, w_down, w_mult;
    wire [3:0] w_s_in, w_s, w_mux_out;
    wire w_cout_add, w_cout_sub, w_cout_inc, w_cout_dec, w_cout_comp, w_cout_up, w_cout_down, w_cout_mult, w_mux_cout;

    //Expand inputs to correct sizes
    assign w_in1 = {4'b0000, in1};
    assign w_in2 = {4'b0000, in2};
    assign w_s_in = {1'b0, s};

    //Load inputs into 8 bit registers
    load_reg_8b load_reg_8b_01(w_reg1, w_in1, ld, rst, clk);
    load_reg_8b load_reg_8b_02(w_reg2, w_in2, ld, rst, clk);
    load_reg_4b load_reg_4b_01(w_s, w_s_in, ld, rst, clk);

    //Registers can hold 8 bits, but these components only process the last 4 bits
    adder_4b adder_4b_00(w_add, w_cout_add, w_reg1[3:0], w_reg2[3:0], 1'b0);
    subtractor_4b subtractor_4b_00(w_sub, w_cout_sub, w_reg1[3:0], w_reg2[3:0]);
    incrementor_4b incrementor_4b_00(w_inc, w_cout_inc, w_reg1[3:0]);
    decrementor_4b decrementor_4b_00(w_dec, w_cout_dec, w_reg1[3:0]);
    comparator_4b comparator_4b_00(w_comp, w_cout_comp, w_reg1[3:0], w_reg2[3:0]);
    up_counter_4b up_counter_4b_00(w_up, w_cout_up, w_reg1[3:0], ld, 1'b1, clk, rst);
    down_counter_4b down_counter_4b_00(w_down, w_cout_down, w_reg1[3:0], ld, 1'b1, clk, rst);
    left_shifter_x1_4b left_shifter_x1_4b_00(w_mult, w_cout_mult, w_reg1[3:0], 1'b0, 1'b1);

    //Pass the out and cout from the selected function into the output variable
    mux_8x1_4b mux_8x1_4b_00(w_mux_out, w_add, w_sub, w_inc, w_dec, w_comp, w_up, w_down, w_mult, w_s[2:0]);
    mux_8x1 mux_8x1_00(w_mux_cout, w_cout_add, w_cout_sub, w_cout_inc, w_cout_dec, w_cout_comp, w_cout_up, w_cout_down, w_cout_mult, w_s[2:0]);
    assign out = {3'b000, w_mux_cout, w_mux_out};

    //Store the output in Reg 3
    load_reg_8b load_reg_8b_03(unused, out, ld, rst, clk);

endmodule