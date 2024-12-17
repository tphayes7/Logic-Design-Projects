`include "Full_Adder.v"
module subtractor_5b(out, num1, num2);
    //5 bit subtractor
    output [4:0] out;
    input [4:0] num1;
    input [4:0] num2;
    wire [4:0] num2_neg;
    wire unused;

    assign num2_neg[0] = ~num2[0];
    assign num2_neg[1] = ~num2[1];
    assign num2_neg[2] = ~num2[2];
    assign num2_neg[3] = ~num2[3];
    assign num2_neg[4] = ~num2[4];

    adder_5b adder_5b_s(out, unused, num1, num2_neg, 1'b1);
endmodule

module subtractor_4b(out, num1, num2);
    //4 bit subtractor
    output [3:0] out;
    input [3:0] num1;
    input [3:0] num2;
    wire [3:0] num2_neg;
    wire unused;

    assign num2_neg[0] = ~num2[0];
    assign num2_neg[1] = ~num2[1];
    assign num2_neg[2] = ~num2[2];
    assign num2_neg[3] = ~num2[3];

    adder_4b adder_4b_s(out, unused, num1, num2_neg, 1'b1);
endmodule

module adder_5b(out, cout, num1, num2, cin);
    //5 bit Adder with cin
    output [4:0] out;
    output cout;
    input [4:0] num1;
    input [4:0] num2;
    input cin;
    wire c1, c2, c3, c4;

    full_adder full_adder_01(out[0], c1, num1[0], num2[0], cin);
    full_adder full_adder_02(out[1], c2, num1[1], num2[1], c1);
    full_adder full_adder_03(out[2], c3, num1[2], num2[2], c2);
    full_adder full_adder_04(out[3], c4, num1[3], num2[3], c3);
    full_adder full_adder_05(out[4], cout, num1[4], num2[4], c4);
endmodule

module adder_4b(out, cout, num1, num2, cin);
    //4 bit Adder with cin
    output [3:0] out;
    output cout;
    input [3:0] num1;
    input [3:0] num2;
    input cin;
    wire c1, c2, c3;

    full_adder full_adder_01(out[0], c1, num1[0], num2[0], cin);
    full_adder full_adder_02(out[1], c2, num1[1], num2[1], c1);
    full_adder full_adder_03(out[2], c3, num1[2], num2[2], c2);
    full_adder full_adder_04(out[3], cout, num1[3], num2[3], c3);
endmodule