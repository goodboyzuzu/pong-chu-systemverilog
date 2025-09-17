`timescale 1ns / 10ps

module eq2_tb;
    logic [1:0] k0, k1;
    logic test_out2;
    eq2 uut (
        .j0(k0),
        .j1(k1),
        .aEqb(test_out2)
    );
    initial begin
        $dumpfile("eq2_tb.vcd");
        $dumpvars(0, eq2_tb);

        k0 = 2'b00; k1 = 2'b00; #10;
        $display("k0=%b k1=%b eq=%b", k0, k1, test_out2);

        k0 = 2'b00; k1 = 2'b01; #10;
        $display("k0=%b k1=%b eq=%b", k0, k1, test_out2);

        k0 = 2'b01; k1 = 2'b00; #10;
        $display("k0=%b k1=%b eq=%b", k0, k1, test_out2);

        k0 = 2'b01; k1 = 2'b01; #10;
        $display("k0=%b k1=%b eq=%b", k0, k1, test_out2);
        $finish;
    end
endmodule