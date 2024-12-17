`include "Mux_2x1_4b.v"
`include "Load_Reg_4b.v"
`include "Decrementor.v"
module down_counter_4b(count, tcount, in, ld, cnt, clk, rst);
    //4-bit Down-Counter
    output [3:0] count;
    output tcount;
    input [3:0] in;
    input ld, cnt, clk, rst;
    wire [3:0] w_mux_out, w_dec_out;
    wire w_ld_in;

    //Either load new value or pass current value to w_mux_out
    mux_2x1_4b mux_2x1_4b_00(w_mux_out, w_dec_out, in, ld);

    //Store value and determine outputs
    assign w_ld_in = ld || cnt;
    load_reg_4b load_reg_4b_00(count, w_mux_out, w_ld_in, rst, clk);
    assign tcount = ~(count[0] || count[1] || count[2] || count[3]);

    //Decrement count
    decrementor_4b decrementor_4b_00(w_dec_out, count);

endmodule