// 1-bit equality comparator with gate-level modeling
module eq1 (
    //IO declaration
    input logic i0,i1,
    output logic eq
);

    //signal declaration
    logic p0, p1;

    //combinational logic
    assign eq = p0 | p1;
    assign p0 = ~i0 & ~i1;
    assign p1 = i0 & i1;
endmodule