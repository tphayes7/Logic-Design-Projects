`timescale 1 ns / 1ns
`include "assert.v"
module down_counter_test;
    wire [3:0] count;
    wire tcount;
    reg [3:0] in;
    reg ld, cnt, clk, rst;
    
    down_counter_4b down_counter_4b_tb(count, tcount, in, ld, cnt, clk, rst);

    always #10 clk = ~clk;
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        in = 4'b0000;
        ld = 1'b0;
        cnt = 1'b0;
        clk= 1'b0;
        rst = 1'b1;

        #11
        `assert(count, 4'b0000, "count", "rst = 1", "count = 0000", "%d")
        `assert(tcount, 1'b1, "tcount", "rst = 1", "tcount = 1", "%d")
        rst = 1'b0;

        #20
        //31 ns
        `assert(count, 4'b0000, "count", "cnt = 0", "count = 0000", "%d")
        `assert(tcount, 1'b1, "tcount", "cnt = 0", "tcount = 1", "%d")

        #20
        //51 ns
        `assert(count, 4'b0000, "count", "cnt = 0", "count = 0000", "%d")
        `assert(tcount, 1'b1, "tcount", "cnt = 0", "tcount = 1", "%d")

        #9
        //60 ns
        cnt = 1'b1;

        #11
        //71 ns
        `assert(count, 4'b1111, "count", "cnt = 1", "count = 1111", "%d")
        `assert(tcount, 1'b0, "tcount", "cnt = 1", "tcount = 0", "%d")

        #20
        //91 ns
        `assert(count, 4'b1110, "count", "cnt = 1", "count = 1110", "%d")
        `assert(tcount, 1'b0, "tcount", "cnt = 1", "tcount = 0", "%d")

        #20
        //111 ns
        `assert(count, 4'b1101, "count", "cnt = 1", "count = 1101", "%d")
        `assert(tcount, 1'b0, "tcount", "cnt = 1", "tcount = 0", "%d")

        #9
        //120 ns
        cnt = 1'b0;
        in = 4'b0011;
        ld = 1'b1;

        #11
        //131 ns
        `assert(count, 4'b0011, "count", "in = 0011", "count = 0011", "%d")
        `assert(tcount, 1'b0, "tcount", "in = 0011", "tcount = 0", "%d")

        #9
        //140 ns
        ld = 1'b0;

        #11
        //151 ns
        `assert(count, 4'b0011, "count", "cnt = 0", "count = 0011", "%d")
        `assert(tcount, 1'b0, "tcount", "cnt = 0", "tcount = 0", "%d")

        #9
        //160 ns
        cnt = 1'b1;

        #11
        //171 ns
        `assert(count, 4'b0010, "count", "cnt = 1", "count = 0010", "%d")
        `assert(tcount, 1'b0, "tcount", "cnt = 1", "tcount = 0", "%d")

        #20
        //191 ns
        `assert(count, 4'b0001, "count", "cnt = 1", "count = 0001", "%d")
        `assert(tcount, 1'b0, "tcount", "cnt = 1", "tcount = 0", "%d")

        #20
        //211 ns
        `assert(count, 4'b0000, "count", "cnt = 1", "count = 0000", "%d")
        `assert(tcount, 1'b1, "tcount", "cnt = 1", "tcount = 1", "%d")

        #20
        //231 ns
        `assert(count, 4'b1111, "count", "cnt = 1", "count = 1111", "%d")
        `assert(tcount, 1'b0, "tcount", "cnt = 1", "tcount = 0", "%d")

    end
    
    initial #240 $finish;

endmodule
