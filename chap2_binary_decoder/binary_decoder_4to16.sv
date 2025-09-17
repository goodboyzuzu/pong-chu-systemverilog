module binary_decoder_4to16 (
    input logic [3:0] binary_in,
    input logic en,
    output logic [15:0] one_hot_out
);
    logic [3:0] en_dec;

    // generate enable signals
    binary_decoder_2to4 dec_en (
        .binary_in(binary_in[3:2]),
        .en(en),
        .one_hot_out(en_dec)
    );

    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : decoders_generate
            binary_decoder_2to4 dec_2to4_insts (
                .en(en_dec[i]),
                .binary_in(binary_in[1:0]),
                .one_hot_out(one_hot_out[i*4 +: 4])
            );
        end
    endgenerate
    
endmodule