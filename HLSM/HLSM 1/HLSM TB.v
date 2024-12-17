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
    wire [3:0] Do, Eo;
    reg [3:0] Di, Ei, F;
    reg b, rst, clk;
    
    HLSM HLSM_00(Do, Eo, b, Di, Ei, F, rst, clk);

    always #10 clk = ~clk;
       
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        Di = 4'b0000;
        Ei = 4'b0000;
        F = 4'b0000;
        b = 1'b0;
        rst = 1'b1;
        clk = 1'b0;

        #11
        `assert(Do, 4'b0000, "Do", "rst = 1", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "rst = 1", "Eo=0", "%d")

        #9 //20 ns
        rst = 1'b0;
        Di = 4'b0010;
        Ei = 4'b0100;
        F = 4'b0010; 
        b = 1'b1;

        #11 //31 ns
        //Pass 2 clock cycles to allow state the possibility to move to 10, 
        //plus one clock cycle delay for the output.
        `assert(Do, 4'b0000, "Do", "Di = 2, Ei = 4, F = 2", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "Di = 2, Ei = 4, F = 2", "Eo=0", "%d")

        #20 //51 ns
        `assert(Do, 4'b0000, "Do", "Di = 2, Ei = 4, F = 2", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "Di = 2, Ei = 4, F = 2", "Eo=0", "%d")

        #20 //71 ns
        `assert(Do, 4'b0000, "Do", "Di = 2, Ei = 4, F = 2", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "Di = 2, Ei = 4, F = 2", "Eo=0", "%d")

        b = 1'b0;
        #40 //111 ns
        //Allow two clock cycles to get back to state 00.

        #9 //120 ns
        Di = 4'b0010;
        Ei = 4'b0100;
        F = 4'b0110;
        b = 1'b1; 

        #11 //131 ns
        //Pass 2 clock cycles to allow state the possibility to move to 10, 
        //plus one clock cycle delay for the output.
        `assert(Do, 4'b0000, "Do", "Di = 2, Ei = 4, F = 6", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "Di = 2, Ei = 4, F = 6", "Eo=0", "%d")

        #20 //151 ns
        `assert(Do, 4'b0000, "Do", "Di = 2, Ei = 4, F = 6", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "Di = 2, Ei = 4, F = 6", "Eo=0", "%d")

        #20 //171 ns
        `assert(Do, 4'b0010, "Do", "Di = 2, Ei = 4, F = 6", "Do=2", "%d")
        `assert(Eo, 4'b0100, "Eo", "Di = 2, Ei = 4, F = 6", "Eo=4", "%d")

        b = 1'b0;
        #40 //211ns
        //Allow two clock cycles to get back to state 00.

        #9 //220 ns
        //Leave inputs the same; should not move out of state 00.

        #11 //231 ns
        //Pass 2 clock cycles to allow state the possibility to move to 10, 
        //plus one clock cycle delay for the output.
        `assert(Do, 4'b0000, "Do", "b = 0", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "b = 0", "Eo=0", "%d")

        #20 //251 ns
        `assert(Do, 4'b0000, "Do", "b = 0", "Do=0", "%d")
        `assert(Eo, 4'b0000, "Eo", "b = 0", "Eo=0", "%d")

        #20 //271 ns
        `assert(Do, 4'b0000, "Do", "b = 0", "Do=2", "%d")
        `assert(Eo, 4'b0000, "Eo", "b = 0", "Eo=4", "%d")

    end
    
    initial #280 $finish;

endmodule