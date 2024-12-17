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

module HLSM_test;
    wire [3:0] result;
    reg [3:0] n;
    reg b, rst, clk;
    
    HLSM HLSM_tb(result, b, n, rst, clk);

    always #10 clk = ~clk;
       
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        n = 4'b0000;
        b = 1'b0;
        rst = 1'b1;
        clk = 1'b0;

        #31 //Give an extra clock cycle for the reset to propagate through the datapath
        `assert(result, 4'b0000, "result", "rst = 1", "result = 0", "%d")

        #9 //40 ns
        rst = 1'b0;
        n = 2;
        b = 1;

        #20 //60 ns
        b = 0;

        #91 //151 ns
        //Should take 7 clock cycles to get a result.  This is the 6th cycle after b was set. 
        `assert(result, 0, "result", "n = 2", "result = 0", "%d")

        #20 //171 ns
        `assert(result, 1, "result", "n = 2", "result = 1", "%d")

        #20 //191 ns
        `assert(result, 0, "result", "n = 2", "result = 0", "%d")

        #9 //200 ns
        n = 5;
        b = 1;

        #20 //220 ns
        b = 0;
        
        #211 //431 ns
        //Should take 13 clock cycles to get a result.  This is the 12th cycle after b was set. 
        `assert(result, 0, "result", "n = 5", "result = 0", "%d")

        #20 //451 ns
        `assert(result, 10, "result", "n = 5", "result = 10", "%d")

        #20 //471 ns
        `assert(result, 0, "result", "n = 5", "result = 0", "%d")

        #9 //480 ns
        n = 10;
        b = 1;

        #20 //500 ns
        b = 0;
        
        #411 //911 ns
        //Should take 23 clock cycles to get a result.  This is the 22nd cycle after b was set. 
        `assert(result, 0, "result", "n = 10", "result = 0", "%d")

        #20 //931 ns
        `assert(result, 13, "result", "n = 10", "result = 13", "%d")

        #20 //951 ns
        `assert(result, 0, "result", "n = 10", "result = 0", "%d")

    end
    
    initial #960 $finish;

endmodule