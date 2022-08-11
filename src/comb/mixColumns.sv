`timescale 1ps/1ps
module mixColumns (
	input [127:0] state,
	output reg [127:0] state_out
);

	function [7:0] MultiplyByTwo;
		input [7:0] x;
		begin
			MultiplyByTwo = x << 1;
			if (x[7] == 1) MultiplyByTwo = (MultiplyByTwo ^ 8'h1b);
		end 	
	endfunction

	function [7:0] MultiplyByThree;
		input [7:0] x;
		begin 
			MultiplyByThree = MultiplyByTwo(x) ^ x;
		end 
	endfunction

	wire [31:0] row0, row1, row2, row3;
	bits2rows b2r_mc (state, row0, row1, row2, row3);

	wire [31:0] row_comb0, row_comb1, row_comb2, row_comb3;
	genvar i;
	generate
	for(i=0; i<4; i=i+1) begin : matrixMultiply
		assign row_comb0[8*i +: 8] = MultiplyByTwo(row0[8*i +: 8]) ^
                                     MultiplyByThree(row1[8*i +: 8]) ^
                                     row2[8*i +: 8] ^
                                     row3[8*i +: 8];

		assign row_comb1[8*i +: 8] = row0[8*i +: 8] ^
									 MultiplyByTwo(row1[8*i +: 8]) ^
									 MultiplyByThree(row2[8*i +: 8]) ^
									 row3[8*i +: 8];

		assign row_comb2[8*i +: 8] = row0[8*i +: 8] ^
									 row1[8*i +: 8] ^
									 MultiplyByTwo(row2[8*i +: 8]) ^
									 MultiplyByThree(row3[8*i +: 8]);

		assign row_comb3[8*i +: 8] = MultiplyByThree(row0[8*i +: 8]) ^
									 row1[8*i +: 8] ^
									 row2[8*i +: 8] ^
									 MultiplyByTwo(row3[8*i +: 8]);
	end
	endgenerate

    rows2bits r2b_mc (row_comb0, row_comb1, row_comb2, row_comb3, state_out);

endmodule
