`include "Comparator.v"
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