`timescale 1 ns / 1ns
`include "assert.v"
module ALU_test;
    wire [7:0] out;
    reg [3:0] in1, in2;
    reg [2:0] s;
    reg ld, rst, clk;
    
    ALU ALU_tb(out, in1, in2, s, ld, rst, clk);

    always #10 clk = ~clk;
       
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        in1 = 4'b0000;
        in2 = 4'b0000;
        s = 3'b000;
        ld = 1'b0;
        rst = 1'b1;
        clk = 1'b0;

        #11
        `assert(out, 8'b00000000, "out", "rst = 1", "out = 00000000", "%d")

        #9
        //20 ns
        rst = 1'b0;
        in1 = 4'b0010;
        in2 = 4'b1010;

        #11
        `assert(out, 8'b00000000, "out", "ld = 0", "out = 00000000", "%d")

        #9
        //40 ns
        ld = 1'b1;

        #11
        `assert(out, 8'b00001100, "out", "0010 + 1010", "out = 00001100", "%d")

        #9
        //60 ns
        in1 = 4'b1110;
        in2 = 4'b1011;

        #11
        `assert(out, 8'b00011001, "out", "1110 + 1011", "out = 00011001", "%d")

        #9
        //80 ns
        in1 = 4'b1010;
        in2 = 4'b1001;
        s = 3'b001;

        #11
        `assert(out, 8'b00000001, "out", "1010 - 1001", "out = 00000001", "%d")

        #9
        //100 ns
        in1 = 4'b0010;
        in2 = 4'b1101;

        #11
        `assert(out, 8'b00000101, "out", "0010 - 1101", "out = 00000101", "%d")

        #9
        //120 ns
        in1 = 4'b0011;
        in2 = 4'b0000;
        s = 3'b010;

        #11
        `assert(out, 8'b00000100, "out", "0011++", "out = 00000100", "%d")

        #9
        //140 ns
        in1 = 4'b1111;

        #11
        `assert(out, 8'b00010000, "out", "1111++", "out = 00010000", "%d")

        #9
        //160 ns
        in1 = 4'b1011;
        s = 3'b011;

        #11
        `assert(out, 8'b00001010, "out", "1011--", "out = 00001010", "%d")

        #9
        //180 ns
        in1 = 4'b0000;

        #11
        `assert(out, 8'b00001111, "out", "0000--", "out = 00001111", "%d")

        #9
        //200 ns
        in1 = 4'b1001;
        in2 = 4'b0010;
        s = 3'b100;

        #11
        `assert(out, 8'b00000100, "out", "1001 comp 0010", "out = 00000100", "%d")

        #9
        //220 ns
        in1 = 4'b0100;
        in2 = 4'b0100;

        #11
        `assert(out, 8'b00000001, "out", "0100 comp 0100", "out = 00000001", "%d")

        #9
        //240 ns
        in1 = 4'b1101;
        in2 = 4'b0000;
        s = 3'b101;

        #31
        //271 ns
        `assert(out, 8'b00001101, "out", "1101 ld", "out = 00001101", "%d")

        #9
        //280 ns
        ld = 1'b0;

        #11
        `assert(out, 8'b00001110, "out", "1101 up", "out = 00001110", "%d")

        #20
        //311 ns
        `assert(out, 8'b00011111, "out", "1110 up", "out = 00011111", "%d")

        #20
        //331 ns
        `assert(out, 8'b00000000, "out", "1111 up", "out = 00000000", "%d")

        #9
        //340 ns
        in1 = 4'b0010;
        ld = 1'b1;
        s = 3'b110;

        #31
        //371 ns
        `assert(out, 8'b00000010, "out", "0010 ld", "out = 00000010", "%d")

        #9
        //380 ns
        ld = 1'b0;

        #11
        `assert(out, 8'b00000001, "out", "0010 down", "out = 00000001", "%d")

        #20
        //411 ns
        `assert(out, 8'b00010000, "out", "0010 down", "out = 00010000", "%d")

        #20
        //431 ns
        `assert(out, 8'b00001111, "out", "0000 down", "out = 00001111", "%d")

        #9
        //440 ns
        in1 = 4'b1011;
        ld = 1'b1;
        s = 3'b111;

        #11
        `assert(out, 8'b00010110, "out", "1011 x 2", "out = 00010110", "%d")

        #9
        //460 ns
        in1 = 4'b0100;

        #11
        `assert(out, 8'b00001000, "out", "0100 x 2", "out = 00001000", "%d")

    end
    
    initial #480 $finish;

endmodule
