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

module cols2bits 
#(parameter SIZE = 128)
(
	input [31:0] cols [0:COL_NUM-1],
    output [SIZE-1:0] out
);

    parameter COL_NUM = SIZE / 32;

    genvar i;
    generate
        for(i=0; i<COL_NUM; i=i+1) begin : cols2bits
            assign out[i*32+:32] = cols[i];
        end
    endgenerate

endmodule