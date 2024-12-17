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