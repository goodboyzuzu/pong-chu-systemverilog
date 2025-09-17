`timescale 1ns / 10ps

module eq1_tb;
    logic i0, i1;
    logic test_out;

    eq1 uut
        (.i0(i0),
        .i1(i1),
        .eq(test_out)
        );
    // initial block for simulation
    initial begin
        $dumpfile("eq1_tb.vcd");
        $dumpvars(0, eq1_tb);

        i0 = 1'b0; i1 = 1'b0; #10;
        $display("i0=%b i1=%b eq=%b", i0, i1, test_out);

        i0 = 1'b0; i1 = 1'b1; #10;
        $display("i0=%b i1=%b eq=%b", i0, i1, test_out);

        i0 = 1'b1; i1 = 1'b0; #10;
        $display("i0=%b i1=%b eq=%b", i0, i1, test_out);

        i0 = 1'b1; i1 = 1'b1; #10;
        $display("i0=%b i1=%b eq=%b", i0, i1, test_out);
        $finish;
    end

endmodule