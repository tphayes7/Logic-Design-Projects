`timescale 1 ns / 1ns
`include "assert.v"
module mux_2x1_4b_test;
    wire [3:0] out;
    reg [3:0] num0, num1;
    reg s;
    
    mux_2x1_4b mux_2x1_4b_tb(out, num0, num1, s);
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        num0 = 4'b1100;
        num1 = 4'b0011;
        s = 1'b0;

        #1
        `assert(out, 4'b1100, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        s = 1'b1;

        #1
        `assert(out, 4'b0011, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        num0 = 4'b1001;
        num1 = 4'b0110;
        s = 1'b0;

        #1
        `assert(out, 4'b1001, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        s = 1'b1;

        #1
        `assert(out, 4'b0110, "E", "A=0, B=0, C=0", "E=0", "%d")
        
        #9
        num0 = 4'b1101;
        num1 = 4'b1011;
        s = 1'b0;

        #1
        `assert(out, 4'b1101, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        s = 1'b1;

        #1
        `assert(out, 4'b1011, "E", "A=0, B=0, C=0", "E=0", "%d")
        
        #9
        num0 = 4'b1111;
        num1 = 4'b0000;
        s = 1'b0;

        #1
        `assert(out, 4'b1111, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        s = 1'b1;

        #1
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #80 $finish;

endmodule
