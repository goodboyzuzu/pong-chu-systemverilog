module barrel_shifter #(
    parameter int WIDTH = 8
)(
    input logic [7:0] arr,
    input logic [2:0] shift,
    output logic [7:0] out
);
    assign out = (arr << shift) | (arr >> (WIDTH - shift));
endmodule

module barrel_shifter_tb;
    logic [7:0] arr;
    logic [2:0] shift;
    logic [7:0] out;

    barrel_shifter uut (
        .arr(arr),
        .shift(shift),
        .out(out)
    );

    initial begin
        arr = 8'b10110011; // Example input
        $display("time \t shift \t out");
        $display("----------------------------------");
        $monitor("%0t \t %b \t %b", $time, shift, out);
        for (int i=0; i<uut.WIDTH; i++) begin
            shift = i;
            #10;
        end
        $finish;
    end
endmodule