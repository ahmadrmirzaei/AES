`timescale 1ps/1ps
module stage4 (
    input clk, rst, en,
    input [127:0] state, key
    output done,
    output [127:0] state_out, key_out
);

    wire [127:0] state_comb;

    addRoundKey ark (state, key, state_comb);
    pipeReg pipe4 (clk, rst, en, state_comb, key, done, state_out, key_out);

endmodule