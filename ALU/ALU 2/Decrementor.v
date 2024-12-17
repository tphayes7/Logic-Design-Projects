module decrementor_4b(out, cout, num);
    //4 bit Decrementor
    output [3:0] out;
    output cout;
    input [3:0] num;
    wire w_b0, w_b1, w_b2, unused;

    half_subtractor half_subtractor_00(out[0], w_b0, num[0], 1'b1);
    half_subtractor half_subtractor_01(out[1], w_b1, num[1], w_b0);
    half_subtractor half_subtractor_02(out[2], w_b2, num[2], w_b1);
    half_subtractor half_subtractor_03(out[3], unused, num[3], w_b2);

    //Conform output to standards
    assign cout = 0;

endmodule

module half_subtractor(out, bout, in1, in2);
    //Half-subtractor
    output out, bout;
    input in1, in2;

    assign out = (in1 && ~in2) || (~in1 && in2);
    assign bout = ~in1 && in2;

endmodule