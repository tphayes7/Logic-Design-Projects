`timescale 1 ns / 1ns
`include "assert.v"
module mux_2x1_4b_test;
    wire [3:0] out;
    reg [3:0] in;
    reg ld, rst, clk;
    
    load_reg_4b load_reg_4b_tb(out, in, ld, rst, clk);

    always #10 clk = ~clk;
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        rst = 1'b1;
        ld = 1'b0;
        clk = 1'b0;

        #11
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")
        rst = 1'b0;

        #9
        //20 ns
        in = 4'b0101;

        #1
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")

        #10
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //40 ns
        ld = 1'b1;

        #1
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")

        #10
        `assert(out, 4'b0101, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //60 ns
        in = 4'b1010;

        #1
        `assert(out, 4'b0101, "E", "A=0, B=0, C=0", "E=0", "%d")

        #10
        `assert(out, 4'b1010, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //80 ns
        in = 4'b1110;
        ld = 1'b0;

        #1
        `assert(out, 4'b1010, "E", "A=0, B=0, C=0", "E=0", "%d")

        #10
        `assert(out, 4'b1010, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //100 ns
        in = 4'b1011;
        ld = 1'b1;

        #1
        `assert(out, 4'b1010, "E", "A=0, B=0, C=0", "E=0", "%d")

        #10
        `assert(out, 4'b1011, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //120 ns
        rst = 1'b1;

        #1
        `assert(out, 4'b1011, "E", "A=0, B=0, C=0", "E=0", "%d")

        #10
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #140 $finish;

endmodule
