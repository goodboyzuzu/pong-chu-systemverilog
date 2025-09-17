module eq2 (
    input logic [1:0] j0,j1,
    output logic aEqb
);
    logic e0, e1;
    assign aEqb = e0 & e1;
    eq1 bit0 (.i0(j0[0]),.i1(j1[0]),.eq(e0));
    eq1 bit1 (.i0(j0[1]),.i1(j1[1]),.eq(e1));
endmodule