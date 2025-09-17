module greater_than_4bit (
    input logic [3:0] i0, i1,
    output logic gt
);
    logic ms2b_gt, ls2b_gt, ms2b_eq;

    assign gt = ms2b_gt | (ms2b_eq & ls2b_gt);

    eq2 eq2_inst (
        .j0(i0[3:2]),
        .j1(i1[3:2]),
        .aEqb(ms2b_eq)
    );

    greater_than_2bit gt_msb_inst (
        .i0(i0[3:2]),
        .i1(i1[3:2]),
        .gt(ms2b_gt)
    );

    greater_than_2bit gt_lsb_inst (
        .i0(i0[1:0]),
        .i1(i1[1:0]),
        .gt(ls2b_gt)
    );

endmodule