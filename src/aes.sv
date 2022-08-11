`include "src/other/pack.sv"
`include "src/other/unpack.sv"
`include "src/other/rotWord.sv"
`include "src/other/rCon.sv"
`include "src/other/sBox.sv"
`include "src/comb/addRoundKey.sv"
`include "src/comb/keyExpansion.sv"
`include "src/comb/mixColumns.sv"
`include "src/comb/shiftRows.sv"
`include "src/comb/subBytes.sv"
`include "src/round.sv"
`timescale 1ps/1ps
module aes 
#(parameter KEY_SIZE = 128)
(
    input clk, rst, en,
    input [127:0] state,
    input [KEY_SIZE-1:0] initialKey,
    output reg done,
    output reg [127:0] state_out
);

    parameter RND_NUM = (KEY_SIZE == 256) ? 14 : (KEY_SIZE == 192) ? 12 : 10;

    reg [3:0] num;
    initial num = 4'h0;

    wire [127:0] state_ark, state_r;

    addRoundKey ark (state, initialKey[127:0], state_ark);
    roundComb #(KEY_SIZE) rComb (state_out, initialKey, num, state_r);

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            num = 4'h0;
            done = 1'b0;
        end
        else if (en) begin
            if (num == 4'h0) begin
                state_out = state_ark;
            end
            else begin
                state_out = state_r;
            end
            if (num == RND_NUM) begin
                num = 4'h0;
                done = 1'b1;
            end
            else
                num = num + 4'd1;
        end
    end

    
endmodule