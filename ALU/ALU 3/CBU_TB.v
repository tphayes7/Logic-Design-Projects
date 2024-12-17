`timescale 1 ns / 1ns

`define assert(actual, expected, outputName, inputs, description, type) \
    $write("\nTIME: "); $write($realtime); \
    if (actual == expected) \
        $display("   PASSED:   "); \
    else begin \
        $display(" ** FAILED:   "); \
        if (description) $display("TEST: %s", description); \
    end \
    $write("%s = ", outputName, type, actual); \
    $write(", EXPECTED: ", type, expected); \
    if (inputs) $display(" WITH: %s", inputs);
// End of `assert macro.

module CBU_test;
    wire [3:0] out;
    reg [8:0] in;
    reg [3:0] a, b;
    reg rst, clk;
    
    CBU CBU_tb(out, in, a, b, rst, clk);

    always #10 clk = ~clk;
       
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        in = 9'b000000000;
        a = 4'b0000;
        b = 4'b0000;
        rst = 1'b1;
        clk = 1'b0;

        #11
        `assert(out, 4'b0000, "out", "rst = 1", "out = 0000", "%d")

        #9 //20 ns, instruct 1 in
        in = 9'b000011011;
        a = 6;
        b = 3;
        rst = 1'b0;

        #20 //40 ns, instruct 2 in
        in = 9'b000011011;
        a = 10;
        b = 7;

        #11 //51 ns, instruct 1 out
        `assert(out, 9, "out", "6 + 3", "out = 9", "%d")

        #9 //60 ns, instruct 3 in
        in = 9'b001011011;
        a = 7;
        b = 2;

        #11 //71 ns, instruct 2 out
        `assert(out, 1, "out", "10 + 7", "out = 1", "%d")

        #9 //80 ns, instruct 4 in
        in = 9'b001011011;
        a = 4'b0010;
        b = 4'b0100;

        #11 //91 ns, instruct 3 out
        `assert(out, 5, "out", "7 - 2", "out = 5", "%d")

        #9 //100 ns, instruct 5 in
        in = 9'b010010010;
        a = 3;

        #11 //111 ns, instruct 4 out
        `assert(out, 4'b1110, "out", "2 - 4", "out = -2", "%d")

        #9 //120 ns, instruct 6 in
        in = 9'b010110001;
        a = 15;

        #11 //131 ns, instruct 5 out
        `assert(out, 4, "out", "3++", "out = 4", "%d")

        #9 //140 ns, instruct 7 in
        in = 9'b011100010;
        a = 9;

        #11 //151 ns, instruct 6 out
        `assert(out, 0, "out", "15++", "out = 0", "%d")

        #9 //160 ns, instruct 8 in
        in = 9'b011010011;
        a = 0;

        #11 //171 ns, instruct 7 out
        `assert(out, 8, "out", "9--", "out = 8", "%d")

        #9 //180 ns, instruct 9 in
        in = 9'b100011010;
        a = 5;
        b = 2;

        #11 //191 ns, instruct 8 out
        `assert(out, 15, "out", "0--", "out = 15", "%d")

        #9 //200 ns, instruct 10 in
        in = 9'b100011101;
        a = 3;
        b = 8;

        #11 //211 ns, instruct 9 out
        `assert(out, 4'b0100, "out", "5 > 2", "out = 0100", "%d")

        #9 //220 ns, instruct 11 in
        in = 9'b100101111;
        a = 4;
        b = 4;

        #11 //231 ns, instruct 10 out
        `assert(out, 4'b0010, "out", "3 < 8", "out = 0010", "%d")

        #9 //240 ns, instruct 12 in
        in = 9'b101000011;

        #11 //251 ns, instruct 11 out
        `assert(out, 4'b0001, "out", "4 = 4", "out = 0001", "%d")

        #20 //271 ns, instruct 12 out
        `assert(out, 0, "out", "0 up", "out = 0", "%d")

        #20 //291 ns, instruct 12 out
        `assert(out, 1, "out", "0 up", "out = 1", "%d")

        #20 //311 ns, instruct 12 out
        `assert(out, 2, "out", "0 up", "out = 2", "%d")

        #20 //331 ns, instruct 12 out
        `assert(out, 3, "out", "0 up", "out = 3", "%d")

        #220 //551 ns, instruct 12 out
        `assert(out, 14, "out", "0 up", "out = 14", "%d")

        #20 //571 ns, instruct 12 out
        `assert(out, 15, "out", "0 up", "out = 15", "%d")

        #9 //580 ns, instruct 13 in
        in = 9'b110000011;

        #11 //591 ns, instruct 12 out
        `assert(out, 0, "out", "0 up", "out = 0", "%d")

        #20 //611 ns, instruct 13 out
        `assert(out, 0, "out", "0 down", "out = 0", "%d")

        #20 //631 ns, instruct 13 out
        `assert(out, 15, "out", "0 down", "out = 15", "%d")

        #20 //651 ns, instruct 13 out
        `assert(out, 14, "out", "0 down", "out = 14", "%d")

        #20 //671 ns, instruct 13 out
        `assert(out, 13, "out", "0 down", "out = 13", "%d")

        #220 //891 ns, instruct 13 out
        `assert(out, 2, "out", "0 down", "out = 2", "%d")

        #20 //911 ns, instruct 13 out
        `assert(out, 1, "out", "0 down", "out = 1", "%d")

        #9 //920 ns, instruct 14 in
        in = 9'b111010011;
        a = 3;

        #11 //931 ns, instruct 13 out
        `assert(out, 0, "out", "0 down", "out = 0", "%d")

        #9 //940 ns, instruct 15 in
        in = 9'b111010011;
        a = 5;

        #11 //951 ns, instruct 14 out
        `assert(out, 6, "out", "3 x 2", "out = 6", "%d")

        #20 //971 ns, instruct 15 out
        `assert(out, 10, "out", "5 x 2", "out = 10", "%d")

    end
    
    initial #980 $finish;

endmodule
