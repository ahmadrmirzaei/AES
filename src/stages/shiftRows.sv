`timescale 1ps/1ps
module shiftRows (
    input clk, rst, en,
    input [127:0] state,
	output reg [127:0] state_out,
	output reg done
);

    wire [31:0] row0, row1, row2, row3;
    bits2rows b2r_sr (state, row0, row1, row2, row3);

    wire [31:0] row_comb0, row_comb1, row_comb2, row_comb3;
    // row 0 no change
    assign row_comb0 = row0;

    //	2nd row , row 1 , 1 shift left 
    assign row_comb1 [0 +: 24] = row1[8 +: 24];
    assign row_comb1 [24 +: 8] = row1[0 +: 8];

    //3rd row , row 2 , 2 shifts left 
    assign row_comb2 [0 +: 16] = row2[16 +: 16];
    assign row_comb2 [16 +: 16] = row2[0 +: 16];

    //4th row , row 3 , 3 shifts left 
    assign row_comb3 [0 +: 8] = row3[24 +: 8];
    assign row_comb3 [8 +: 24] = row3[0 +: 24];

    wire [127:0] state_out_comb;
    rows2bits r2b_sr (row_comb0, row_comb1, row_comb2, row_comb3, state_out_comb);

    pipeReg pipe_sr (clk, rst, en, state_out_comb, state_out, done);
    // assign state_out = state_out_comb;


    // initial begin
    //     #100;
    //     $display("shiftRows\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n",
    //         state_out[0+:8], state_out[32+:8], state_out[64+:8], state_out[96+:8],
    //         state_out[8+:8], state_out[40+:8], state_out[72+:8], state_out[104+:8],
    //         state_out[16+:8], state_out[48+:8], state_out[80+:8], state_out[112+:8],
    //         state_out[24+:8], state_out[56+:8], state_out[88+:8], state_out[120+:8]
    //         );
    // end

endmodule

