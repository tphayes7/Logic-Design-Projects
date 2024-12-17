`timescale 1 ns / 1ns
`include "assert.v"
module comparator_test;
    wire gto, lto, eqo;
    reg [3:0] num1, num2;
    
    comparator_4b comparator_4b_tb(gto, lto, eqo, num1, num2);
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        num1 = 4'b0000;
        num2 = 4'b0000;

        #1
        `assert(gto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0100;
        num2 = 4'b0010;

        #1
        `assert(gto, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0111;
        num2 = 4'b1000;

        #1
        `assert(gto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0110;
        num2 = 4'b0110;

        #1
        `assert(gto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b1010;
        num2 = 4'b0101;

        #1
        `assert(gto, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0110;
        num2 = 4'b0111;

        #1
        `assert(gto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b1010;
        num2 = 4'b1010;

        #1
        `assert(gto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0010;
        num2 = 4'b0001;

        #1
        `assert(gto, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0001;
        num2 = 4'b1111;

        #1
        `assert(gto, 0, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(lto, 1, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(eqo, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #90 $finish;

endmodule
