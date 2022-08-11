`timescale 1ps/1ps
module keyExpansion
#(parameter KEY_SIZE = 128)
(
    input [KEY_SIZE-1:0] initialKey,
	input [3:0] num,
    output reg [127:0] roundKey
);

    parameter RND_NUM = (KEY_SIZE == 256) ? 15 : (KEY_SIZE == 192) ? 13 : 11;
    parameter EXTEND_KEY_SIZE = RND_NUM * 128;
    parameter KEY_RND_NUM = (EXTEND_KEY_SIZE - 128) / KEY_SIZE;
    parameter COL_NUM = KEY_SIZE / 32;


    reg [EXTEND_KEY_SIZE-1:0] keys;
    reg [KEY_SIZE-1:0] inKey;

    wire [31:0] cols [COL_NUM-1:0];
    bits2cols #(KEY_SIZE) b2c_ke (inKey, cols);

    wire [31:0] rcol;
    rotWord rw_ke3 (cols[COL_NUM-1], rcol);

    wire [31:0] scol;
    subBytesCol sbc_ke (rcol, scol);

    wire [31:0] rcon;
    rCon rc_ke (num+4'b1, rcon);

    wire [31:0] rconcol;
    assign rconcol = scol ^ rcon;

    wire [31:0] sColOut3;
    subBytesCol sbc_ke_256 (colsOut[3], sColOut3);

    wire [31:0] colsOut [COL_NUM-1:0];
    assign colsOut[0] = cols[0] ^ rconcol;
    genvar i;
    generate
        for (i=1; i<COL_NUM; i=i+1) begin : keyExpansion
            if (KEY_SIZE == 256 && i == 4) begin
                assign colsOut[i] = cols[i] ^ sColOut3;
            end
            else begin
                assign colsOut[i] = cols[i] ^ colsOut[i-1];
            end
        end
    endgenerate

    wire [KEY_SIZE-1:0] outKey;
    cols2bits #(KEY_SIZE) c2b_ke (colsOut, outKey);

    initial begin
        if (num == 4'h0) begin
            inKey = initialKey;
            keys[0+:KEY_SIZE] = initialKey;
        end
    end

    always @(num) begin
        if (num == 4'h0) begin
            inKey = initialKey;
            keys[0+:KEY_SIZE] = initialKey;
        end
        else if (num <= KEY_RND_NUM) begin
            inKey = outKey;
            keys[num*KEY_SIZE+:KEY_SIZE] = outKey;
        end
        roundKey = keys[num*128+:128];
    end

endmodule