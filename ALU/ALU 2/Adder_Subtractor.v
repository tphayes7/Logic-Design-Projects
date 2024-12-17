module subtractor_4b(out, cout, num1, num2);
    //4 bit subtractor
    output [3:0] out;
    output cout;
    input [3:0] num1;
    input [3:0] num2;
    wire [3:0] num2_neg;
    wire unused;

    assign num2_neg[0] = ~num2[0];
    assign num2_neg[1] = ~num2[1];
    assign num2_neg[2] = ~num2[2];
    assign num2_neg[3] = ~num2[3];

    adder_4b adder_4b_s(out, unused, num1, num2_neg, 1'b1);
    
    //Conform output to standards
    assign cout = 0;

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