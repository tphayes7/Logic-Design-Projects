`include "Adder_4b.v"
`include "Subtractor.v"
`include "Mux_2x1_4b.v"
module ALU(out, cout, in1, in2, s);
    //2 function, 4-bit ALU
    //s = 0:  Adder
    //s = 1:  Subtractor
    output [3:0] out;
    output cout;
    input [3:0] in1, in2;
    input s;
    wire [3:0] w_add, w_sub;

    assign cout = 0;
    adder_4b adder_4b_00(w_add, cout, in1, in2);
    subtractor_4b subtractor_4b_00(w_sub, in1, in2);

    mux_2x1_4b mux_2x1_4b_00(out, w_add, w_sub, s);

endmodule