`timescale 1ps/1ps
module stage0 (
    input clk, rst, en,
    input [127:0] state, key,
    output done,
    output [127:0] state_out, key_out
);

    wire [127:0] state_comb;
    wire [3:0] useless;

    addRoundKey ark0 (state, key, state_comb);
    pipeReg pipe0 (clk, rst, en, state_comb, key, 4'h0, done, state_out, key_out, useless);

endmodule