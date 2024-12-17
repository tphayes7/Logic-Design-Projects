`include "Mux_8x1.v"
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