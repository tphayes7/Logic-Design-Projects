`include "Full_Adder.v"
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