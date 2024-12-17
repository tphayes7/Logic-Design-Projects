`include "Adder_Subtractor.v"
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
    wire w_cout_add;

    adder_4b adder_4b_00(w_add, w_cout_add, in1, in2, 1'b0);
    subtractor_4b subtractor_4b_00(w_sub, in1, in2);

    mux_2x1_4b mux_2x1_4b_00(out, w_add, w_sub, s);
    mux_2x1 mux_2x1_00(cout, w_cout_add, 1'b0, s);    

endmodule