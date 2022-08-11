`timescale 1ps/1ps
module keyExpansion (
    input [127:0] keyIn,
	input [3:0] keyNum,
    output [127:0] keyOut
);

    wire [31:0] col0, col1, col2, col3;
    bits2cols b2c_ke (keyIn, col0, col1, col2, col3);

    wire [31:0] rcol3;
    rotWord rw_ke3 (col3, rcol3);

    wire [31:0] scol3;
    subBytesCol sbc_ke (rcol3, scol3);

    wire [31:0] rcon;
    rCon rc_ke (keyNum, rcon);

    wire [31:0] rconcol3;
    assign rconcol3 = scol3 ^ rcon;

    wire [31:0] colOut0, colOut1, colOut2, colOut3;
    assign colOut0 = col0 ^ rconcol3;
    assign colOut1 = col1 ^ colOut0;
    assign colOut2 = col2 ^ colOut1;
    assign colOut3 = col3 ^ colOut2;

    cols2bits c2b_ke (colOut0, colOut1, colOut2, colOut3, keyOut);

endmodule

