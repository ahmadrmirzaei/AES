`timescale 1ps/1ps
module rows2bits (
	input [31:0] row0, row1, row2, row3,
    output [127:0] out
);

    assign out = {row3[24 +: 8], row2[24 +: 8], row1[24 +: 8], row0[24 +: 8],
                  row3[16 +: 8], row2[16 +: 8], row1[16 +: 8], row0[16 +: 8],
                  row3[8 +: 8], row2[8 +: 8], row1[8 +: 8], row0[8 +: 8],
                  row3[0 +: 8], row2[0 +: 8], row1[0 +: 8], row0[0 +: 8]
                 };

endmodule

module cols2bits (
	input [31:0] col0, col1, col2, col3,
    output [127:0] out
);

    assign out = {col3, col2, col1, col0};

endmodule