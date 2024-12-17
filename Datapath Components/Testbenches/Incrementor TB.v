`timescale 1 ns / 1ns
`include "assert.v"
module incrementor_test;
    wire [3:0] out;
    wire cout;
    reg [3:0] num;
    
    incrementor_4b incrementor_4b_tb(out, cout, num);
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        num = 4'b0000; 

        #1
        `assert(out, 4'b0001, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num = 4'b0010; 

        #1
        `assert(out, 4'b0011, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num = 4'b0100; 

        #1
        `assert(out, 4'b0101, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num = 4'b1000; 

        #1
        `assert(out, 4'b1001, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num = 4'b0110; 

        #1
        `assert(out, 4'b0111, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num = 4'b1001; 

        #1
        `assert(out, 4'b1010, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num = 4'b1011; 

        #1
        `assert(out, 4'b1100, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num = 4'b1111; 

        #1
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #80 $finish;

endmodule
