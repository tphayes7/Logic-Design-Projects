`include "Subtractor.v"
module decrementor_4b(out, num);
    //4 bit Decrementor
    output [3:0] out;
    input [3:0] num;
    wire [4:0] w_s_num, w_s_out;

    //Since the subtractor takes signed values, we need to convert the input to a positive signed value.
    assign w_s_num = {1'b0, num};

    //Subtract 1
    subtractor_5b subtractor_5b_00(w_s_out, w_s_num, 5b'00001);

    //Unsign the output
    assign out = w_s_out[3:0];

endmodule

module decrementor_4b_v2(out, num);
    //4 bit Decrementor
    output [3:0] out;
    input [3:0] num;
    wire w_b0, w_b1, w_b2, unused;

    half_subtractor half_subtractor_00(out[0], w_b0, num[0], 1'b1);
    half_subtractor half_subtractor_01(out[1], w_b1, num[1], w_b0);
    half_subtractor half_subtractor_02(out[2], w_b2, num[2], w_b1);
    half_subtractor half_subtractor_03(out[3], unused, num[3], w_b2);

endmodule

module half_subtractor(out, bout, in1, in2);
    //Half-subtractor
    output out, bout;
    input in1, in2;

    assign out = (in1 && ~in2) || (~in1 && in2);
    assign bout = ~in1 && in2;

endmodule