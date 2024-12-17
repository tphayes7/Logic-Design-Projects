module mux_8x1(out, i0, i1, i2, i3, i4, i5, i6, i7, s);
    //1-bit 8x1 Mux
    output out;
    input i0, i1, i2, i3, i4, i5, i6, i7;
    input [2:0] s;

    assign out = (~s[2] && ~s[1] && ~s[0] && i0) || (~s[2] && ~s[1] && s[0] && i1) || (~s[2] && s[1] && ~s[0] && i2) || (~s[2] && s[1] && s[0] && i3) || (s[2] && ~s[1] && ~s[0] && i4) || (s[2] && ~s[1] && s[0] && i5) || (s[2] && s[1] && ~s[0] && i6) || (s[2] && s[1] && s[0] && i7);
    
endmodule