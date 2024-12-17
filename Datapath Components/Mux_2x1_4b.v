`include "Mux_2x1.v"
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