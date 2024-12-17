`timescale 1 ns / 1ns
`include "assert.v"
module left_shifter_x1_4b_test;
    wire [3:0] out;
    wire cout;
    reg [3:0] in;
    reg cin, sh;
    
    left_shifter_x1_4b left_shifter_x1_4b_tb(out, cout, in, cin, sh);
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        in = 4'b0110;
        cin = 1'b0;
        sh = 1'b0;

        #1
        `assert(out, 4'b0110, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 4'b1010;
        sh = 1'b1;

        #1
        `assert(out, 4'b0100, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b1, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 4'b1110;
        sh = 1'b0;

        #1
        `assert(out, 4'b1110, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b0, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 4'b1011;
        sh = 1'b1;
        cin = 1'b1;

        #1
        `assert(out, 4'b0111, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 1'b1, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #40 $finish;

endmodule
