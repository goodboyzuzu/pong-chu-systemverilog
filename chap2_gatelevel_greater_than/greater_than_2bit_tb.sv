`timescale 1ns / 10ps

module greater_than_2bit_tb;
    logic [1:0] i0, i1;
    logic test_out;

    greater_than_2bit uut
        (.i0(i0),
        .i1(i1),
        .gt(test_out)
        );
    // initial block for simulation
    initial begin
        $dumpfile("greater_than_2bit_tb.vcd");
        $dumpvars(0, greater_than_2bit_tb);

        for (int i=0; i<4; i++) begin
            for (int j=0; j<4; j++) begin
                i0 = i; i1 = j; #10;
                $monitor("i0=%b i1=%b gt=%b", i0, i1, test_out);
            end
        end
        $finish;
    end
endmodule