`include "src/other/pipeReg.sv"
`include "src/other/sBox.sv"
`include "src/other/rCon.sv"
`include "src/other/rotWord.sv"
`include "src/other/pack.sv"
`include "src/other/unpack.sv"
`include "src/stages/addRoundKey.sv"
`include "src/stages/subBytes.sv"
`include "src/stages/shiftRows.sv"
`include "src/stages/mixColumns.sv"
`include "src/stages/keyExpansion.sv"
`include "src/round.sv"
`timescale 1ps/1ps

module aes (
    input clk, rst, en,
    input [127:0] key,
    input [127:0] state,
    output reg [127:0] state_out,
    output reg done
);
	
    wire [127:0] state0, state1, state2, state3, state4, state5, state6, state7, state8, state9;
    wire [127:0] key1, key2, key3, key4, key5, key6, key7, key8, key9;
    wire done0, done1, done2, done3, done4, done5, done6, done7, done8, done9;

    addRoundKey adk_aes (clk, rst, en, key, state, state0, done0);
    round r1 (clk, rst, done0, key, state0, 4'h1, key1, state1, done1);
    round r2 (clk, rst, done1, key1, state1, 4'h2, key2, state2, done2);
    round r3 (clk, rst, done2, key2, state2, 4'h3, key3, state3, done3);
    round r4 (clk, rst, done3, key3, state3, 4'h4, key4, state4, done4);
    round r5 (clk, rst, done4, key4, state4, 4'h5, key5, state5, done5);
    round r6 (clk, rst, done5, key5, state5, 4'h6, key6, state6, done6);
    round r7 (clk, rst, done6, key6, state6, 4'h7, key7, state7, done7);
    round r8 (clk, rst, done7, key7, state7, 4'h8, key8, state8, done8);
    round r9 (clk, rst, done8, key8, state8, 4'h9, key9, state9, done9);
    lastRound r10 (clk, rst, done9, key9, state9, state_out, done);
    
endmodule