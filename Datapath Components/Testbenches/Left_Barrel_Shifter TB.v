`timescale 1 ns / 1ns
`include "assert.v"
module left_barrel_shifter_x7_8b_test;
    wire [7:0] out;
    wire [7:0] cout;
    reg [7:0] in;
    reg [7:0] cin;
    reg [2:0] sh;
    
    left_barrel_shifter_x7_8b left_barrel_shifter_x7_8b_tb(out, cout, in, cin, sh);
   
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(1);
    
        in = 8'b01101011;
        cin = 8'b01000101;
        sh = 3'b000;

        #1
        `assert(out, 8'b01101011, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00000000, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 8'b01011001;
        cin = 8'b01110101;
        sh = 3'b001;

        #1
        `assert(out, 8'b10110010, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00000000, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 8'b01101011;
        cin = 8'b10010101;
        sh = 3'b010;

        #1
        `assert(out, 8'b10101110, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00000001, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 8'b00101011;
        cin = 8'b01100101;
        sh = 3'b011;

        #1
        `assert(out, 8'b01011011, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00000001, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 8'b10010101;
        cin = 8'b11001011;
        sh = 3'b100;

        #1
        `assert(out, 8'b01011100, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00001001, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 8'b01000101;
        cin = 8'b10010101;
        sh = 3'b101;

        #1
        `assert(out, 8'b10110010, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00001000, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 8'b10010110;
        cin = 8'b01001001;
        sh = 3'b110;

        #1
        `assert(out, 8'b10010010, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00100101, "E", "A=0, B=0, C=0", "E=0", "%d")

        #9
        in = 8'b01001000;
        cin = 8'b01100110;
        sh = 3'b111;

        #1
        `assert(out, 8'b00110011, "E", "A=0, B=0, C=0", "E=0", "%d")
        `assert(cout, 8'b00100100, "E", "A=0, B=0, C=0", "E=0", "%d")

    end
    
    initial #80 $finish;

endmodule
