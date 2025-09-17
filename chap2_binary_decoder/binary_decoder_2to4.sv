module binary_decoder_2to4 (
    input logic [1:0] binary_in,
    input logic en,
    output logic [3:0] one_hot_out
);
    always_comb begin
        if (en) begin
            case (binary_in)
                2'b00: one_hot_out = 4'b0001;
                2'b01: one_hot_out = 4'b0010;
                2'b10: one_hot_out = 4'b0100;
                2'b11: one_hot_out = 4'b1000;
                default: one_hot_out = 4'b0000;
            endcase
        end
        else begin
            one_hot_out = 4'b0000;
        end
    end
endmodule