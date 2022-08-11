`timescale 1ps/1ps
module rotWord (
	input [31:0] wordIn,
    output [31:0] wordOut
);

    assign wordOut[0 +: 24] = wordIn[8 +: 24];
    assign wordOut[24 +: 8] = wordIn[0 +: 8];

endmodule