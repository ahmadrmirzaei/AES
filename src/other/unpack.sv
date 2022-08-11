`timescale 1ps/1ps
module bits2rows (
	input [127:0] in,
	output [31:0] row0, row1, row2, row3
);

    assign row0 = {in[96 +: 8], in[64 +: 8], in[32 +: 8], in[0 +: 8]};
    assign row1 = {in[104 +: 8], in[72 +: 8], in[40 +: 8], in[8 +: 8]};
    assign row2 = {in[112 +: 8], in[80 +: 8], in[48 +: 8], in[16 +: 8]};
    assign row3 = {in[120 +: 8], in[88 +: 8], in[56 +: 8], in[24 +: 8]};

endmodule

module bits2cols (
	input [127:0] in,
	output [31:0] col0, col1, col2, col3
);

    assign col0 = in[0 +: 32];
    assign col1 = in[32 +: 32];
    assign col2 = in[64 +: 32];
    assign col3 = in[96 +: 32];

endmodule