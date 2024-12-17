`include "Mux_2x1.v"
module left_shifter_x4_4b(out, cout, in, cin, sh);
    //4-bit 4 x Left Shifter
    output [3:0] out;
    output [3:0] cout;
    input [3:0] in;
    input [3:0] cin;
    input sh;

    mux_2x1 mux_2x1_00(out[0], in[0], cin[0], sh);
    mux_2x1 mux_2x1_01(out[1], in[1], cin[1], sh);
    mux_2x1 mux_2x1_02(out[2], in[2], cin[2], sh);
    mux_2x1 mux_2x1_03(out[3], in[3], cin[3], sh);
    assign cout[0] = sh && in[0];
    assign cout[1] = sh && in[1];
    assign cout[2] = sh && in[2];
    assign cout[3] = sh && in[3];

endmodule