module multi_driver(
    input  logic a,
    input  logic b,
    input  logic sela,
    input  logic selb,
    inout  tri   bus // output works too. inout means able to be driven by external source besides module
);

    // Driver 1: drives bus when sel is 0
    assign bus = (sela) ? a : 1'bz;

    // Driver 2: drives bus when sel is 1
    assign bus = (selb) ? b : 1'bz;

endmodule

module tb_multi_driver;
    logic a, b, sela, selb;
    tri bus;

    // Instantiate the DUT
    multi_driver dut(
        .a(a),
        .b(b),
        .sela(sela),
        .selb(selb),
        .bus(bus)
    );

    initial begin
        $dumpfile("multi_driver.vcd");
        $dumpvars(0, tb_multi_driver);
        $display("Time\t a b sela selb | bus");
        $monitor("%0t\t %b %b  %b     %b  |  %b", $time, a, b, sela, selb, bus);
        // Test: drive a, then b
        a = 1'b1; b = 1'b0; sela = 1'b1; selb = 1'b0; #10;
        a = 1'b0; b = 1'b1; sela = 1'b0; selb = 1'b1; #10; // Switch drivers
        a = 1'b1; b = 1'b0; sela = 1'b1; selb = 1'b1; #10; // Both driving: bus 'x' don't care
        a = 1'b1; b = 1'b1; sela = 1'b1; selb = 1'b1; #10; // Both driving same value: bus '1'
        a = 1'b0; b = 1'b0; sela = 1'b0; selb = 1'b0; #10; // Both high impedance: bus 'z'
        $finish;
    end
endmodule