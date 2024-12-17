module down_counter_4b(count, tcount, in, ld, cnt, clk, rst);
    //4-bit Down-Counter
    output [3:0] count;
    output tcount;
    input [3:0] in;
    input ld, cnt, clk, rst;
    wire [3:0] w_mux_out, w_dec_out;
    wire w_ld_in, unused;

    //Either load new value or pass current value to w_mux_out
    mux_2x1_4b mux_2x1_4b_00(w_mux_out, w_dec_out, in, ld);

    //Store value and determine outputs
    assign w_ld_in = ld || cnt;
    load_reg_4b load_reg_4b_00(count, w_mux_out, w_ld_in, rst, clk);
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