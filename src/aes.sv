`include "src/other/pack.sv"
`include "src/other/unpack.sv"
`include "src/other/pipeReg.sv"
`include "src/other/rotWord.sv"
`include "src/other/rCon.sv"
`include "src/other/sBox.sv"
`include "src/comb/addRoundKey.sv"
`include "src/comb/keyExpansion.sv"
`include "src/comb/mixColumns.sv"
`include "src/comb/shiftRows.sv"
`include "src/comb/subBytes.sv"
`include "src/stages/stage0.sv"
`include "src/stages/stage1.sv"
`include "src/stages/stage2.sv"
`include "src/stages/stage3.sv"
`include "src/stages/stage4.sv"
`include "src/round.sv"
`timescale 1ps/1ps
module aes (
    input clk, rst, en,
    input [127:0] state, key,
    output reg done,
    output [127:0] state_out, key_out
);

    // reg [127:0] state = 128'hff6ec9c370a6678992b1fb90f3fd6595;
    // reg [127:0] key = 128'h01010101010101010101010101010101;

    initial begin
        done <= 1'b0;
    end

    wire [127:0] state0;
    wire [127:0] key0;
    wire done0, done_r;

    reg [3:0] num;
    initial num = 4'h0;

    wire [127:0] state_r = (num == 4'h1) ? state0 : state_out;
    wire [127:0] key_r = (num == 4'h1) ? key0 : key_out;
    wire en_r = (num == 4'h1) ? done0 : done_r;
    wire count = en || done_r;

    stage0 s0 (clk, rst, en, state, key, done0, state0, key0);
    round r (clk, rst, en_r, state_out, key_out, num, done_r, state_out, key_out);

    always @(posedge rst, posedge count) begin
        if (rst)
            num <= 4'h0;
        else if (num == 4'ha && done_r) begin
            done <= 1'b1;
            num <= 4'h0;
        end
        else
            num = num + 1;
    end
    
endmodule