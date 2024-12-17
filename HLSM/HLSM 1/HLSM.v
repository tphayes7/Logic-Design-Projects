module HLSM(Do, Eo, b, Di, Ei, F, rst, clk);
    //HLSM 5.8.4
    output [3:0] Do, Eo;
    input [3:0] Di, Ei, F;
    input b, rst, clk;
    wire w_DE_eq_F, w_E_s, w_E_ld, w_D_s, w_D_ld;

    Controller Controller_00(w_E_s, w_E_ld, w_D_s, w_D_ld, b, w_DE_eq_F, rst, clk);
    DataPath DataPath_00(Do, Eo, w_DE_eq_F, Di, Ei, F, w_E_s, w_E_ld, w_D_s, w_D_ld, rst, clk);

endmodule

module Controller(E_s, E_ld, D_s, D_ld, b, DE_eq_F, rst, clk);
    //Controller for HLSM 5.8.4
    output E_s, E_ld, D_s, D_ld;
    input b, DE_eq_F, rst, clk;
    wire [1:0] w_n, w_p;

    reg_2b reg_2b_state(w_p, w_n, rst, clk);

    assign w_n[1] = ~w_p[1] && w_p[0] && DE_eq_F;
    assign w_n[0] = ~w_p[1] && ~w_p[0] && b;
    assign E_s = w_p[1] && ~w_p[0];
    assign E_ld = ~w_p[0];
    assign D_s = w_p[1] && ~w_p[0];
    assign D_ld = ~w_p[0];

endmodule

module DataPath(Do, Eo, DE_eq_F, Di, Ei, F, E_s, E_ld, D_s, D_ld, rst, clk);
    //DataPath for HLSM 5.8.4
    output [3:0] Do, Eo;
    output DE_eq_F;
    input [3:0] Di, Ei, F;
    input E_s, E_ld, D_s, D_ld, rst, clk;
    wire [3:0] w_add_out, w_E_mux_out, w_D_mux_out;
    wire unused;

    adder_4b adder_4b_Di_Ei(w_add_out, unused, Di, Ei);
    comparator_4b comparator_4b_DiEi_F(unused, unused, DE_eq_F, w_add_out, F);
    mux_2x1_4b mux_2x1_4b_E(w_E_mux_out, 4'b0000, Ei, E_s);
    load_reg_4b load_reg_4b_E(Eo, w_E_mux_out, E_ld, rst, clk);
    mux_2x1_4b mux_2x1_4b_D(w_D_mux_out, 4'b0000, Di, D_s);
    load_reg_4b load_reg_4b_D(Do, w_D_mux_out, D_ld, rst, clk);

endmodule

module adder_4b(out, cout, num1, num2);
    //4 bit Adder
    output [3:0] out;
    output cout;
    input [3:0] num1;
    input [3:0] num2;
    wire c1, c2, c3;

    full_adder full_adder_01(out[0], c1, num1[0], num2[0], 1'b0);
    full_adder full_adder_02(out[1], c2, num1[1], num2[1], c1);
    full_adder full_adder_03(out[2], c3, num1[2], num2[2], c2);
    full_adder full_adder_04(out[3], cout, num1[3], num2[3], c3);
endmodule

module full_adder(a, cout, i1, i2, cin);
    //Full Adder
    output a, cout;
    input i1, i2, cin;
    wire w_a1, w_c1, w_c2;

    half_adder half_adder_01(w_a1, w_c1, i1, i2);
    half_adder half_adder_02(a, w_c2, cin, w_a1);

    assign cout = w_c1 || w_c2;
endmodule

module half_adder(a, c, i1, i2);
    //Half-Adder
    output a, c;
    input i1, i2;

    //EDA Playground didn't like xor
    //assign a = i1 xor i2;
    assign a = (i1 && ~i2) || (~i1 && i2);
    assign c = i1 && i2;
endmodule

module comparator_4b(gto, lto, eqo, num1, num2);
    //4 bit comparator
    output gto, lto, eqo;
    input [3:0] num1, num2;
    wire w_gt03, w_gt02, w_gt01, w_lt03, w_lt02, w_lt01, w_eq03, w_eq02, w_eq01;

    comparator comparator03(w_gt03, w_lt03, w_eq03, num1[3], num2[3], 1'b0, 1'b0, 1'b1);
    comparator comparator02(w_gt02, w_lt02, w_eq02, num1[2], num2[2], w_gt03, w_lt03, w_eq03);
    comparator comparator01(w_gt01, w_lt01, w_eq01, num1[1], num2[1], w_gt02, w_lt02, w_eq02);
    comparator comparator00(gto, lto, eqo, num1[0], num2[0], w_gt01, w_lt01, w_eq01);

endmodule

module comparator(gto, lto, eqo, num1, num2, gti, lti, eqi);
    //Comparator
    output gto, lto, eqo;
    input num1, num2, gti, lti, eqi;

    assign gto = gti || (eqi && num1 && ~num2);
    assign lto = lti || (eqi && ~num1 && num2);
    assign eqo = eqi && ((num1 && num2) || (~num1 && ~num2));
    
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

module reg_2b(out, in, rst, clk);
    output [1:0] out;
    input [1:0] in;
    input rst, clk;

    D_FF D_Reg00(out[0], in[0], rst, clk);
    D_FF D_Reg01(out[1], in[1], rst, clk);

endmodule