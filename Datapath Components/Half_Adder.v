module half_adder(a, c, i1, i2);
    //Half-Adder
    output a, c;
    input i1, i2;

    //EDA Playground didn't like xor
    //assign a = i1 xor i2;
    assign a = (i1 && ~i2) || (~i1 && i2);
    assign c = i1 && i2;
endmodule