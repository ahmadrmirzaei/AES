`timescale 1ps/1ps
// module round (
//     input clk, rst, en,
//     input [127:0] state, key,
//     input [3:0] num,
//     output done,
//     output [127:0] state_out, key_out
// );
	
//     wire [127:0] state1, state2, state3;
//     wire [127:0] key1, key2, key3;
//     wire [3:0] num1, num2, num3, num4;
//     wire done1, done2, done3;

//     stage1 s1 (clk, rst, en, state, key, num, done1, state1, key1);
//     stage2 s2 (clk, rst, done1, state1, key1, done2, state2, key2);
//     stage3 s3 (clk, rst, done2, state2, key2, num2, done3, state3, key3);
//     stage4 s4 (clk, rst, done3, state3, key3, done, state_out, key_out);

// endmodule

module roundComb
#(parameter KEY_SIZE = 128)
(
    input [127:0] state,
    input [KEY_SIZE-1:0] initialKey,
    input [3:0] num,
    output [127:0] state_out
);

    parameter RND_NUM = (KEY_SIZE == 256) ? 14 : (KEY_SIZE == 192) ? 12 : 10;

    wire [127:0] state_sb, state_sr, state_mc, round_key;

    subBytes sb (state, state_sb);
    keyExpansion #(KEY_SIZE) ke (initialKey, num, round_key);
    shiftRows sr (state_sb, state_sr);
    mixColumns mc (state_sr, state_mc);
    wire [127:0] state_ark_in = (num == RND_NUM) ? state_sr : state_mc;
    addRoundKey ark (state_ark_in, round_key, state_out);

endmodule