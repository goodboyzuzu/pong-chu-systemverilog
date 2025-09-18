module xor_reduction_tb;
    logic [4:0] a5;
    logic [1:0] a2;
    logic a1;
    logic y;

    initial begin
        a5 = 5'b10101;
        y = ^a5; 
        $display("a5 = %b, y = %b", a5, y);

        a2 = 2'b10;
        y = ^a2; 
        $display("a2 = %b, y = %b", a2, y);

        a2 = 2'b11;
        y = ^a2; 
        $display("a2 = %b, y = %b", a2, y);

        a1 = 1'b1;
        y = ^a1;
        $display("a1 = %b, y = %b", a1, y);

        a1 = 1'b0;
        y = ^a1;
        $display("a1 = %b, y = %b", a1, y);

        $finish;
    end

endmodule