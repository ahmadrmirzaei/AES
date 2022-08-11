`timescale 1ps/1ps
module stage3 (
    input clk, rst, en,
    input [127:0] state, key,
    input [3:0] num,
    output done,
    output [127:0] state_out, key_out
);

    wire [127:0] state_mc, state_comb;
    
    mixColumns mc (state, state_mc);
    assign state_comb = (num == 4'ha) ? state : state_mc;
    pipeReg pipe3 (clk, rst, en, state_comb, key, done, state_out, key_out);

endmodule