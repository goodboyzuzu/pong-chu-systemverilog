module priority_encoder_demo
(
    input logic en,
    input logic [1:0] in,
    output logic [2:0] out
);

    always_comb begin : priority_encoder_block
        casez({en,in})
            3'b1??: out=3'b100; //Use X to represent dont care
            3'b010, 3'b011: out=3'b010;
            3'b001: out=3'b001;
            default: out=3'b000;
        endcase
    end
endmodule

module priority_encoder_demo_tb;
    logic en;
    logic [1:0] in;
    logic [2:0] out;

    priority_encoder_demo dut (
        .en(en),
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("priority_encoder_demo.vcd");
        $dumpvars(0, priority_encoder_demo_tb);
        $display("Time\t en in | out");
        $monitor("%0t\t %b %b | %b", $time, en, in, out);
        
        // Test cases
        en = 1'b0; in = 2'b00; #10;
        en = 1'b0; in = 2'b01; #10;
        en = 1'b0; in = 2'b10; #10;
        en = 1'b0; in = 2'b11; #10;
        en = 1'b1; in = 2'b00; #10; // those with en=1 output will be 000 as case 3'b1XX requires X and not 1 or 0.
        en = 1'b1; in = 2'b01; #10;
        en = 1'b1; in = 2'b10; #10;
        en = 1'b1; in = 2'b11; #10;
        $finish;
    end

endmodule