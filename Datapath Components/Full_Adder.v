`include "Half_Adder.v"
module full_adder(a, cout, i1, i2, cin);
    //Full Adder
    output a, cout;
    input i1, i2, cin;
    wire w_a1, w_c1, w_c2;

    half_adder half_adder_01(w_a1, w_c1, i1, i2);
    half_adder half_adder_02(a, w_c2, cin, w_a1);

    assign cout = w_c1 || w_c2;
endmodule