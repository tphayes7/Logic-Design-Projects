`include "Left_Shifter_x1_4b.v"
`include "Left_Shifter_x2_4b.v"
`include "Left_Shifter_x4_4b.v"
module left_barrel_shifter_x7_8b(out, cout, in, cin, sh);
    //8-bit 0-7 x Left Barrel Shifter
    output [7:0] out;
    output [7:0] cout;
    input [7:0] in;
    input [7:0] cin;
    input [2:0] sh;

    //Wire has to be input length + maximum shift to avoid data loss.
    wire [15:0] w_in, w_out_4, w_out_2, w_out_1;
    wire [7:0] w_cin_2, w_cin_1;

    //These wires are used to pass cout on shifter chains
    wire [3:0] w_x4_30, w_x4_74, w_x4_118, w_x4_30_c;
    wire [1:0] w_x2_30, w_x2_74, w_x2_118, w_x2_30_c;
    wire w_x1_30, w_x1_74, w_x1_118;

    //These wires are will not hold anything, but are needed to avoid errors.
    wire [3:0] w_cout_4;
    wire [1:0] w_cout_2;
    wire w_cout_1;

    //Set wire initially to hold input plus buffer.
    assign w_in = {8'b00000000, in};

    //Handle the 4-bit shift
    left_shifter_x4_4b left_shifter_x4_4b_00(w_out_4[3:0], w_x4_30, w_in[3:0], cin[7:4], sh[2]);
    left_shifter_x4_4b left_shifter_x4_4b_01(w_out_4[7:4], w_x4_74, w_in[7:4], w_x4_30, sh[2]);
    left_shifter_x4_4b left_shifter_x4_4b_02(w_out_4[11:8], w_x4_118, w_in[11:8], w_x4_74, sh[2]);
    left_shifter_x4_4b left_shifter_x4_4b_03(w_out_4[15:12], w_cout_4, w_in[15:12], w_x4_118, sh[2]);

    //Shift the cin as needed
    left_shifter_x4_4b left_shifter_x4_4b_04(w_cin_2[3:0], w_x4_30_c, cin[3:0], 4'b0000, sh[2]);
    left_shifter_x4_4b left_shifter_x4_4b_05(w_cin_2[7:4], w_cout_4, cin[7:4], w_x4_30_c, sh[2]);

    //Handle the 2-bit shift
    left_shifter_x2_4b left_shifter_x2_4b_00(w_out_2[3:0], w_x2_30, w_out_4[3:0], w_cin_2[7:6], sh[1]);
    left_shifter_x2_4b left_shifter_x2_4b_01(w_out_2[7:4], w_x2_74, w_out_4[7:4], w_x2_30, sh[1]);
    left_shifter_x2_4b left_shifter_x2_4b_02(w_out_2[11:8], w_x2_118, w_out_4[11:8], w_x2_74, sh[1]);
    left_shifter_x2_4b left_shifter_x2_4b_03(w_out_2[15:12], w_cout_2, w_out_4[15:12], w_x2_118, sh[1]);

    //Shift the cin as needed
    left_shifter_x2_4b left_shifter_x2_4b_04(w_cin_1[3:0], w_x2_30_c, w_cin_2[3:0], 2'b00, sh[1]);
    left_shifter_x2_4b left_shifter_x2_4b_05(w_cin_1[7:4], w_cout_2, w_cin_2[7:4], w_x2_30_c, sh[1]);

    //Handle the 1-bit shift
    left_shifter_x1_4b left_shifter_x1_4b_00(w_out_1[3:0], w_x1_30, w_out_2[3:0], w_cin_1[7], sh[0]);
    left_shifter_x1_4b left_shifter_x1_4b_01(w_out_1[7:4], w_x1_74, w_out_2[7:4], w_x1_30, sh[0]);
    left_shifter_x1_4b left_shifter_x1_4b_02(w_out_1[11:8], w_x1_118, w_out_2[11:8], w_x1_74, sh[0]);
    left_shifter_x1_4b left_shifter_x1_4b_03(w_out_1[15:12], w_cout_1, w_out_2[15:12], w_x1_118, sh[0]);

    //Populate out and cout from the wire
    assign out = w_out_1[7:0];
    assign cout = w_out_1[15:8];

endmodule