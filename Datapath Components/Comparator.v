module comparator(gto, lto, eqo, num1, num2, gti, lti, eqi);
    //Comparator
    output gto, lto, eqo;
    input num1, num2, gti, lti, eqi;

    assign gto = gti || (eqi && num1 && ~num2);
    assign lto = lti || (eqi && ~num1 && num2);
    assign eqo = eqi && ((num1 && num2) || (~num1 && ~num2));
    
endmodule