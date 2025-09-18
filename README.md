# pong-chu-systemverilog

The concept of "blocking" vs. "non-blocking" assignments (= vs. <=) is relevant to procedural blocks like initial, always, and always_ff

iverilog -g2012 -o eq1_tb.vvp eq1.sv eq1_tb.sv
    -g2012 enables SystemVerilog-2012 support.
    -o eq1_tb.vvp sets the output file.
vvp eq1_tb.vvp (vvp is intermediate file from iverilog)
gtkwave eq1_tb.vcd

procedural vs continuous assignments
- procedural: inside initial, always, always_ff blocks
- continuous: outside procedural blocks, using assign keyword
- procedural assignments can be blocking (=) or non-blocking (<=)
- continuous assignments use assign keyword and are always active

# constant
localparam: constant within module
module();
    localparam int WIDTH = 8;
endmodule

parameter: constant that can be overridden during module instantiation
module #(parameter int WIDTH = 8) ();

# replicate structure
generate
    genvar i;
    for (i = 0; i < 4; i++) begin : gen_block
endgenerate
- besides generate, for loop can also be used in initial, always blocks