`timescale 1 ns / 1ns
`include "assert.v"
module subtractor_test;
    wire [3:0] out;
    reg [3:0] num1, num2;
    
    subtractor_4b subtractor_4b_tb(out, num1, num2);
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        num1 = 4'b0000;
        num2 = 4'b0000; 

        #1
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0100;
        num2 = 4'b0010; 

        #1
        `assert(out, 4'b0010, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0110;
        num2 = 4'b0011; 

        #1
        `assert(out, 4'b0011, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0001;
        num2 = 4'b1011; 

        #1
        `assert(out, 4'b0110, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b1111;
        num2 = 4'b0100; 

        #1
        `assert(out, 4'b1011, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b1110;
        num2 = 4'b0010; 

        #1
        `assert(out, 4'b1100, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0101;
        num2 = 4'b1110; 

        #1
        `assert(out, 4'b0111, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num1 = 4'b0111;
        num2 = 4'b0101; 

        #1
        `assert(out, 4'b0010, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #80 $finish;

endmodule
