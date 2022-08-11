`timescale 1ps/1ps
module stage2 (
    input clk, rst, en,
    input [127:0] state, key,
    output done,
    output [127:0] state_out, key_out
);

    wire [127:0] state_comb;

    shiftRows sr (state, state_comb);
    pipeReg pipe2 (clk, rst, en, state_comb, key, done, state_out, key_out);

endmodule