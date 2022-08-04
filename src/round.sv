`timescale 1ps/1ps
module round (
    input clk, rst, en,
    input [127:0] key,
    input [127:0] state,
    input [3:0] round_num,
    output [127:0] key_out,
    output [127:0] state_out,
    output done
);
	
    wire [127:0] state_sb, state_sr, state_mc, state_ark;
    wire done_sb, done_sr, done_mc, done_ark;    
    wire [127:0] round_key;

    keyExpansion r_ke (key, round_num, round_key);

    subBytes r_sb (clk, rst, en, state, state_sb, done_sb);
    shiftRows r_sr (clk, rst, done_sb, state_sb, state_sr, done_sr);
    mixColumns r_mc (clk, rst, done_sr, state_sr, state_mc, done_mc);
    addRoundKey r_ark (clk, rst, done_mc, round_key, state_mc, state_ark, done_ark);

    assign key_out = round_key;
    assign state_out = state_ark;
    assign done = done_ark;

endmodule

module lastRound (
    input clk, rst, en,
    input [127:0] key,
    input [127:0] state,
    output [127:0] state_out,
    output done
);
	
    wire [127:0] state_sb, state_sr, state_ark;
    wire done_sb, done_sr, done_ark;    
    wire [127:0] round_key;

    keyExpansion r_ke (key, 4'ha, round_key);

    subBytes r_sb (clk, rst, en, state, state_sb, done_sb);
    shiftRows r_sr (clk, rst, done_sb, state_sb, state_sr, done_sr);
    addRoundKey r_ark (clk, rst, done_sr, round_key, state_sr, state_ark, done_ark);

    assign state_out = state_ark;
    assign done = done_ark;

endmodule