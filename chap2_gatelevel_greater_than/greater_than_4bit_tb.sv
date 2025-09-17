`timescale 1ns/1ps

module greater_than_4bit_tb;
    logic [3:0] i0, i1;
    logic test_out;

    greater_than_4bit uut
        (.i0(i0),
        .i1(i1),
        .gt(test_out)
        );
    // initial block for simulation
    initial begin
        $dumpfile("greater_than_4bit_tb.vcd");
        $dumpvars(0, greater_than_4bit_tb);

        for (int i=0; i<16; i++) begin
            for (int j=0; j<16; j++) begin
                i0 = i; i1 = j; #10;
                $display("i0=%b i1=%b gt=%b", i0, i1, test_out);
            end
        end
        $finish;
    end
endmodule