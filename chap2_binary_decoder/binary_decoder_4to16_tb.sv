module binary_decoder_4to16_tb;
    logic [3:0] binary_in;
    logic en;
    logic [15:0] test_out;

    binary_decoder_4to16 uut
        (.binary_in(binary_in),
        .en(en),
        .one_hot_out(test_out)
        );
    // initial block for simulation
    initial begin
        $dumpfile("binary_decoder_4to16_tb.vcd");
        $dumpvars(0, binary_decoder_4to16_tb);
        $monitor("binary_in=%b en=%b one_hot_out=%b", binary_in, en, test_out);
        for (int i=0; i<16; i++) begin
            binary_in = i; en = 1'b1; #10;
        end
        for (int i=0; i<16; i++) begin
            binary_in = i; en = 1'b0; #10;
        end
        $finish;
    end
endmodule