module HLSM(result, b, n, rst, clk);
    //HLSM 5.8.4
    output [3:0] result;
    input [3:0] n;
    input b, rst, clk;
    wire w_i_lt_n, w_i_ld, w_sum_ld, w_res_ld, w_dp_rst;

    Controller Controller_00(w_i_ld, w_sum_ld, w_res_ld, w_dp_rst, b, w_i_lt_n, rst, clk);
    DataPath DataPath_00(result, w_i_lt_n, n, w_i_ld, w_sum_ld, w_res_ld, w_dp_rst, clk);

endmodule

module Controller(i_ld, sum_ld, res_ld, dp_rst, b, i_lt_n, rst, clk);
    //Controller for HLSM 5.13.4b
    output i_ld, sum_ld, res_ld, dp_rst;
    input b, i_lt_n, rst, clk;
    wire [1:0] w_n, w_p;
    wire w_state_x;

    reg_2b reg_2b_state(w_p, w_n, rst, clk);

    assign w_n[1] = (~w_p[1] && b) || (~w_p[1] && w_p[0]) || (w_p[1] && ~w_p[0] && ~i_lt_n);
    assign w_n[0] = w_p[1] && ~w_p[0];
    assign w_state_x = ~w_p[1] && w_p[0];
    assign i_ld = w_state_x;
    assign sum_ld = w_state_x;
    assign res_ld = w_p[1] && w_p[0];
    assign dp_rst = ~w_p[1] && ~ w_p[0];

endmodule

module DataPath(result, i_lt_n, n, i_ld, sum_ld, res_ld, rst, clk);
    //DataPath for HLSM 5.13.4b
    output [3:0] result;
    output i_lt_n;
    input [3:0] n;
    input i_ld, sum_ld, res_ld, rst, clk;
    wire [3:0] w_i_inc_out, w_i_reg_out, w_sum_add_out, w_sum_reg_out;
    wire unused;

    load_reg_4b load_reg_4b_i(w_i_reg_out, w_i_inc_out, i_ld, rst, clk);
    load_reg_4b load_reg_4b_sum(w_sum_reg_out, w_sum_add_out, sum_ld, rst, clk);
    load_reg_4b load_reg_4b_res(result, w_sum_reg_out, res_ld, rst, clk);
    comparator_4b comparator_4b_i_n(unused, i_lt_n, unused, w_i_reg_out, n);
    incrementor_4b incrementor_4b_i(w_i_inc_out, unused, w_i_reg_out);
    adder_4b adder_4b_sum_i(w_sum_add_out, unused, w_sum_reg_out, w_i_reg_out);

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

module mux_2x1(out, i0, i1, s);
    //1-bit 2x1 Mux
    output out;
    input i0, i1, s;

    assign out = (~s && i0) || (s && i1);
    
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

module incrementor_4b(out, cout, num);
    //4 bit Incrementor
    output [3:0] out;
    output cout; //Indicates overflow
    input [3:0] num;
    wire w_c0, w_c1, w_c2;

    half_adder half_adder_0(out[0], w_c0, num[0], 1'b1);
    half_adder half_adder_1(out[1], w_c1, num[1], w_c0);
    half_adder half_adder_2(out[2], w_c2, num[2], w_c1);
    half_adder half_adder_3(out[3], cout, num[3], w_c2);

endmodule

module reg_2b(out, in, rst, clk);
    output [1:0] out;
    input [1:0] in;
    input rst, clk;

    D_FF D_Reg00(out[0], in[0], rst, clk);
    D_FF D_Reg01(out[1], in[1], rst, clk);

endmodule