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

module bits2cols
#(parameter SIZE = 128)
(
	input [SIZE-1:0] in,
	output [31:0] cols [0:COL_NUM-1]
);

    parameter COL_NUM = SIZE / 32;

    genvar i;
    generate
        for (i=0; i<COL_NUM; i=i+1) begin : bits2cols
            assign cols[i] = in[32*i +: 32];
        end
    endgenerate
endmodule