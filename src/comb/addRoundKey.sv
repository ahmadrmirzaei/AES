`timescale 1ps/1ps
module addRoundKey (
	input [127:0] state,
    input [127:0] key,
	output [127:0] state_out
);

    genvar i;
    generate
    for (i=0; i<16; i=i+1) begin : addRoundKey
    	assign state_out[i*8 +: 8] = state[i*8 +: 8] ^ key[i*8 +: 8];
    end
    endgenerate

endmodule