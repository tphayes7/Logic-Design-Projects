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