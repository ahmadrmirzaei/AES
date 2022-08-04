`timescale 1ps/1ps
module subBytes (
    input clk, rst, en,
	input [127:0] state,
	output reg [127:0] state_out,
    output reg done
);

    wire [127:0] state_out_comb; 
	genvar i;
    for (i=0; i<16; i=i+1)
        sBox sb_sb (state[8*i +: 8], state_out_comb[8*i +: 8]);

    pipeReg pipe_sb (clk, rst, en, state_out_comb, state_out, done);
    // assign state_out = state_out_comb;

    // initial begin
    //     #100;
    //     $display("subBytes\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n",
    //         state_out[0+:8], state_out[32+:8], state_out[64+:8], state_out[96+:8],
    //         state_out[8+:8], state_out[40+:8], state_out[72+:8], state_out[104+:8],
    //         state_out[16+:8], state_out[48+:8], state_out[80+:8], state_out[112+:8],
    //         state_out[24+:8], state_out[56+:8], state_out[88+:8], state_out[120+:8]
    //         );
    // end

endmodule

module subBytesCol (
	input [31:0] colIn,
	output reg [31:0] colOut
);

	genvar i;
    for (i=0; i<4; i=i+1)
        sBox sb_sbc (colIn[8*i +: 8], colOut[8*i +: 8]);

endmodule