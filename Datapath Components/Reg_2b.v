`include "D_FF.v"
module reg_2b(out, in, rst, clk);
    output [1:0] out;
    input [1:0] in;
    input rst, clk;

    D_FF D_Reg00(out[0], in[0], rst, clk);
    D_FF D_Reg01(out[1], in[1], rst, clk);

endmodule