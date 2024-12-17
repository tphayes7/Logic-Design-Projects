module D_FF(q, d, rst, clk);
    output q;
    input d, rst, clk;
    reg q;

    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else
            q <= d;
    end
endmodule