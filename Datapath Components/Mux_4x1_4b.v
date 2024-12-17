`include "Mux_4x1.v"
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