`timescale 1ps/1ps
module mixColumns (
    input  clk, rst, en,
	input [127:0] state,
	output reg [127:0] state_out,
	output reg done
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
	for(i=0; i<4; i=i+1) begin
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


    wire [127:0] state_out_comb;
    rows2bits r2b_mc (row_comb0, row_comb1, row_comb2, row_comb3, state_out_comb);

	pipeReg pipe_mc (clk, rst, en, state_out_comb, state_out, done);
	// assign state_out = state_out_comb;

    // initial begin
	// 	#100;
    //     $display("mixColumns\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n",
    //         state_out[0+:8], state_out[32+:8], state_out[64+:8], state_out[96+:8],
    //         state_out[8+:8], state_out[40+:8], state_out[72+:8], state_out[104+:8],
    //         state_out[16+:8], state_out[48+:8], state_out[80+:8], state_out[112+:8],
    //         state_out[24+:8], state_out[56+:8], state_out[88+:8], state_out[120+:8]
    //         );
    // end

endmodule
