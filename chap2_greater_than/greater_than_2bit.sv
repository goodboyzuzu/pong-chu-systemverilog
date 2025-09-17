// checks if 2-bit input i0 is greater than i1
module greater_than_2bit (
    input logic [1:0] i0, i1,
    output logic gt
);
    logic msb_gt, lsb_gt, msb_eq;

    // check if msb is equal
    eq1 eq1_inst (
        .i0(i0[1]),
        .i1(i1[1]),
        .eq(msb_eq)
    );
    // MSB greater than
    assign msb_gt = i0[1] & ~i1[1];
    // LSB greater than
    assign lsb_gt = msb_eq & i0[0] & ~i1[0];
    // final output
    assign gt = msb_gt | lsb_gt;

endmodule