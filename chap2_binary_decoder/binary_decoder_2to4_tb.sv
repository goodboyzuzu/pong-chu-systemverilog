module binary_decoder_2to4_tb;
    logic [1:0] binary_in;
    logic en;
    logic [3:0] test_out;

    binary_decoder_2to4 uut
        (.binary_in(binary_in),
        .en(en),
        .one_hot_out(test_out)
        );
    // initial block for simulation
    initial begin
        $dumpfile("binary_decoder_2to4_tb.vcd");
        $dumpvars(0, binary_decoder_2to4_tb);
        $monitor("binary_in=%b en=%b one_hot_out=%b", binary_in, en, test_out);
        for (int i=0; i<4; i++) begin
            binary_in = i; en = 1'b1; #10;
        end
        for (int i=0; i<4; i++) begin
            binary_in = i; en = 1'b0; #10;
        end
    end
endmodule