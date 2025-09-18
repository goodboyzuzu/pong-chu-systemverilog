// sort align add/sub normalize
//suffix: b-> big number, s-> small number, a-> aligned, r-> result of add/sub, n-> normalized

module fp_adder (
    input logic sign1, sign2,
    input logic [3:0] exp1, exp2,
    input logic [7:0] frac1, frac2,
    output logic sign_out,
    output logic [3:0] exp_out,
    output logic [7:0] frac_out
);
logic signb, signs;
logic [3:0] expb, exps, expn, exp_diff;
logic [7:0] fracb, fracs, fraca, fracn, sum_norm;
logic [8:0] sum;
logic [2:0] lead0;
// logic [15:0] sum_intermediate;

always_comb
begin
    // step 1: sort to big and small
    if ({exp1, frac1} >{exp2, frac2}) begin
        signb = sign1; signs = sign2;
        expb = exp1; exps = exp2;
        fracb = frac1; fracs = frac2;
    end
    else begin
        signb = sign2; signs = sign1;
        expb = exp2; exps = exp1;
        fracb = frac2; fracs = frac1;
    end

    // step 2: align smaller number
    exp_diff = expb - exps;
    fraca = fracs >> exp_diff;

    // step 3: add or sub
    if (signb==signs)
        sum = {1'b0, fracb} + {1'b0, fraca}; // add
    else
        sum = {1'b0, fracb} - {1'b0, fraca}; // sub
    
    // step 4: normalize
    if (sum[7])
        lead0 = 3'd0;
    else if (sum[6])
        lead0 = 3'd1;
    else if (sum[5])
        lead0 = 3'd2;
    else if (sum[4])
        lead0 = 3'd3;
    else if (sum[3])
        lead0 = 3'd4;
    else if (sum[2])
        lead0 = 3'd5;
    else if (sum[1])
        lead0 = 3'd6;
    else if (sum[0])
        lead0 = 3'd7;
    else
        lead0 = 3'd7;
    sum_norm = sum[7:0] << lead0;

    //carry-out: shift fraction to right
    if (sum[8]) begin
        expn = expb + 1;
        fracn = sum[8:1]; // shift right
        end
    else if ({1'b0, lead0} > expb) begin // too small to normalize. limitation: does not allow exponent to be negative
        expn = 0;
        fracn = 0; 
    end
    else begin
        expn = expb - lead0;
        fracn = sum_norm; // shift left
    end

    // step 5: output
    sign_out = signb;
    exp_out = expn;
    frac_out = fracn;
end
endmodule

// Disable filename mismatch warning for the testbench (module name differs from file)
/* verilator lint_off DECLFILENAME */

module fp_adder_tb;
    // Testbench signals
    logic tb_sign1, tb_sign2;
    logic [3:0] tb_exp1, tb_exp2;
    logic [7:0] tb_frac1, tb_frac2;
    logic tb_sign_out;
    logic [3:0] tb_exp_out;
    logic [7:0] tb_frac_out;

    // Instantiate DUT
    fp_adder dut (
        .sign1(tb_sign1), .sign2(tb_sign2),
        .exp1(tb_exp1), .exp2(tb_exp2),
        .frac1(tb_frac1), .frac2(tb_frac2),
        .sign_out(tb_sign_out), .exp_out(tb_exp_out), .frac_out(tb_frac_out)
    );

    initial begin
        // VCD dump
        $dumpfile("fp_adder_tb.vcd");
        $dumpvars(0, fp_adder_tb);

        // Header
        $display("time sign1 exp1 frac1 | sign2 exp2 frac2 => sign_out exp_out frac_out");

        // Test 1: simple add, same exponent
        tb_sign1 = 0; tb_exp1 = 4'd5; tb_frac1 = 8'h80; // approx 1.0
        tb_sign2 = 0; tb_exp2 = 4'd5; tb_frac2 = 8'h40; // approx 0.5
        #5; $display("%0t %b   %0d   %h | %b   %0d   %h => %b   %0d   %h", $time, tb_sign1, tb_exp1, tb_frac1, tb_sign2, tb_exp2, tb_frac2, tb_sign_out, tb_exp_out, tb_frac_out);

        // Test 2: different exponents
        // frac2:1100->0011. 
        tb_sign1 = 0; tb_exp1 = 4'd6; tb_frac1 = 8'h40;
        tb_sign2 = 0; tb_exp2 = 4'd4; tb_frac2 = 8'hC0;
        #5; $display("%0t %b   %0d   %h | %b   %0d   %h => %b   %0d   %h", $time, tb_sign1, tb_exp1, tb_frac1, tb_sign2, tb_exp2, tb_frac2, tb_sign_out, tb_exp_out, tb_frac_out);

        // Test 3: subtraction (different signs)
        tb_sign1 = 0; tb_exp1 = 4'd5; tb_frac1 = 8'h80;
        tb_sign2 = 1; tb_exp2 = 4'd5; tb_frac2 = 8'h40;
        #5; $display("%0t %b   %0d   %h | %b   %0d   %h => %b   %0d   %h", $time, tb_sign1, tb_exp1, tb_frac1, tb_sign2, tb_exp2, tb_frac2, tb_sign_out, tb_exp_out, tb_frac_out);

        // Test 4: underflow/too small to normalize
        tb_sign1 = 0; tb_exp1 = 4'd2; tb_frac1 = 8'h10;
        tb_sign2 = 1; tb_exp2 = 4'd0; tb_frac2 = 8'h08;
        #5; $display("%0t %b   %0d   %h | %b   %0d   %h => %b   %0d   %h", $time, tb_sign1, tb_exp1, tb_frac1, tb_sign2, tb_exp2, tb_frac2, tb_sign_out, tb_exp_out, tb_frac_out);

        #5; $finish;
    end

endmodule
/* verilator lint_on DECLFILENAME */
