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

module load_reg(out, in, ld, rst, clk);
    //1-bit Load Register
    output out;
    input in, ld, rst, clk;
    wire w_mux_out, w_out;

    assign w_out = out;
    mux_2x1 mux_2x1_00(w_mux_out, w_out, in, ld);
    D_FF D_FF_00(out, w_mux_out, rst, clk);
    
endmodule

module D_FF(q, d, rst, clk);
    output q;
    input d, rst, clk;
    reg q;

    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule