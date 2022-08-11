`timescale 1ps/1ps
module stage1 (
    input clk, rst, en,
    input [127:0] state, key,
    input [3:0] num,
    output done,
    output [127:0] state_out, key_out,
    output [3:0] num_out
);

    wire [127:0] state_comb, key_comb;

    subBytes sb (state, state_comb);
    keyExpansion ke (key, num, key_comb);
    pipeReg pipe1 (clk, rst, en, state_comb, key_comb, num, done, state_out, key_out, num_out);

endmodule