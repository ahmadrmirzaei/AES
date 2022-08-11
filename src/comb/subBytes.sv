`timescale 1ps/1ps
module subBytes (
	input [127:0] state,
	output reg [127:0] state_out
);

	genvar i;
    generate
        for (i=0; i<16; i=i+1) begin : sBox
            sBox sb_sb (state[8*i +: 8], state_out[8*i +: 8]);
        end      
    endgenerate

endmodule

module subBytesCol (
	input [31:0] colIn,
	output reg [31:0] colOut
);

    genvar i;
    generate
    for (i=0; i<4; i=i+1) begin : sBox
	    sBox sb_sbc (colIn[8*i +: 8], colOut[8*i +: 8]);
    end
    endgenerate

endmodule