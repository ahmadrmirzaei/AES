`timescale 1ps/1ps
module stage4 (
    input clk, rst, en,
    input [127:0] state, key,
    input [3:0] num,
    output done,
    output [127:0] state_out, key_out,
    output [3:0] num_out
);

    wire [127:0] state_comb;

    addRoundKey ark (state, key, state_comb);
    pipeReg pipe4 (clk, rst, en, state_comb, key, num, done, state_out, key_out, num_out);

endmodule