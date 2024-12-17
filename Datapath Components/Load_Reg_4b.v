`include "Load_Reg.v"
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