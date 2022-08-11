`timescale 1ps/1ps
module shiftRows (
    input [127:0] state,
	output reg [127:0] state_out
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

    rows2bits r2b_sr (row_comb0, row_comb1, row_comb2, row_comb3, state_out);

endmodule

