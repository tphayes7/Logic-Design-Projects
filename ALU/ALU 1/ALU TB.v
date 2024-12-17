`timescale 1 ns / 1ns
`include "assert.v"
`include "Load_Reg_4b.v"
module ALU_test;
    wire [3:0] out, w_reg1, w_reg2;
    wire cout, w_s;
    reg [3:0] in1, in2;
    reg s, ld, rst, clk;
    
    load_reg_4b load_reg_4b_01(w_reg1, in1, ld, rst, clk);
    load_reg_4b load_reg_4b_02(w_reg2, in2, ld, rst, clk);
    load_reg load_reg_00(w_s, s, ld, rst, clk);
    ALU ALU_tb(out, cout, w_reg1, w_reg2, w_s);

    always #10 clk = ~clk;
       
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1, ALU_tb);
    
        in1 = 4'b0000;
        in2 = 4'b0000;
        s = 1'b0;
        ld = 1'b0;
        rst = 1'b1;
        clk = 1'b0;

        #11
        `assert(out, 4'b0000, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //20 ns
        ld = 1'b1;
        rst = 1'b0;
        in1 = 4'b0010;
        in2 = 4'b1010;

        #11
        `assert(out, 4'b1100, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //40 ns
        in1 = 4'b1101;
        in2 = 4'b0111;

        #11
        `assert(out, 4'b0100, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //60 ns
        ld = 1'b0;
        in1 = 4'b0110;
        in2 = 4'b0001;

        #11
        `assert(out, 4'b0100, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //80 ns
        s = 1'b1;
        ld = 1'b1;
        in1 = 4'b0110;
        in2 = 4'b0011;

        #11
        `assert(out, 4'b0011, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        //100 ns
        in1 = 4'b1001;
        in2 = 4'b1100;

        #11
        `assert(out, 4'b1101, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b0, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #120 $finish;

endmodule
