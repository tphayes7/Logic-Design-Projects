`timescale 1 ns / 1ns
`include "assert.v"
module full_adder_test;
    wire out, cout;
    reg num1, num2, cin;
    
    full_adder full_adder_tb(out, cout, num1, num2, cin);
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        num1 = 1'b0; 
        num2 = 1'b0;
        cin = 1'b0;

        #1
        `assert(out, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 1'b0;
        num2 = 1'b1;
        cin = 1'b0;

        #1
        `assert(out, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 1'b1;
        num2 = 1'b0;
        cin = 1'b0;

        #1
        `assert(out, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 1'b1;
        num2 = 1'b1;
        cin = 1'b0;

        #1
        `assert(out, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 1'b0; 
        num2 = 1'b0;
        cin = 1'b1;

        #1
        `assert(out, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 1'b0;
        num2 = 1'b1;
        cin = 1'b1;

        #1
        `assert(out, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 1'b1;
        num2 = 1'b0;
        cin = 1'b1;

        #1
        `assert(out, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 1'b1;
        num2 = 1'b1;
        cin = 1'b1;

        #1
        `assert(out, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #80 $finish;

endmodule
