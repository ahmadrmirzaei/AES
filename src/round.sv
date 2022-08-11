`timescale 1ps/1ps
module round (
    input clk, rst, en,
    input [127:0] state, key,
    input [3:0] num,
    output done,
    output [127:0] state_out, key_out
);
	
    wire [127:0] state1, state2, state3;
    wire [127:0] key1, key2, key3;
    wire [3:0] num1, num2, num3, num4;
    wire done1, done2, done3;

    stage1 s1 (clk, rst, en, state, key, num, done1, state1, key1, num1);
    stage2 s2 (clk, rst, done1, state1, key1, num1, done2, state2, key2, num2);
    stage3 s3 (clk, rst, done2, state2, key2, num2, done3, state3, key3, num3);
    stage4 s4 (clk, rst, done3, state3, key3, num3, done, state_out, key_out, num4);

endmodule