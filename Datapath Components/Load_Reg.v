`include "Mux_2x1.v"
`include "D_FF.v"
module load_reg(out, in, ld, rst, clk);
    //1-bit Load Register
    output out;
    input in, ld, rst, clk;
    wire w_mux_out, w_out;

    assign w_out = out;
    mux_2x1 mux_2x1_00(w_mux_out, w_out, in, ld);
    D_FF D_FF_00(out, w_mux_out, rst, clk);
    
endmodule