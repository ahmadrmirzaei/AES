`include "src/aes.sv"
`timescale 1ps/1ps
module aes_tb;
	reg [127:0] state = 128'h000102030405060708090a0b0c0d0e0f;
	reg [191:0] key = 192'h010101010101010101010101010101010101010101010101;
	reg clk = 1; 
    reg rst = 1;
    reg en = 0;
	wire [127:0] state_out;
	wire done;

    aes #(192) uut (clk, rst, en, state, key, done, state_out);

    always #(1) clk = ~clk;
    always @(posedge done) begin
        $display("%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n",
                state_out[0+:8], state_out[32+:8], state_out[64+:8], state_out[96+:8],
                state_out[8+:8], state_out[40+:8], state_out[72+:8], state_out[104+:8],
                state_out[16+:8], state_out[48+:8], state_out[80+:8], state_out[112+:8],
                state_out[24+:8], state_out[56+:8], state_out[88+:8], state_out[120+:8]
                );
        $finish;
    end

    initial begin
        $dumpfile("build/test.vcd");
        $dumpvars(0);
        #5 rst = 0;
        #5 en = 1;
        $display("%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n",
                state[0+:8], state[32+:8], state[64+:8], state[96+:8],
                state[8+:8], state[40+:8], state[72+:8], state[104+:8],
                state[16+:8], state[48+:8], state[80+:8], state[112+:8],
                state[24+:8], state[56+:8], state[88+:8], state[120+:8]
                );
        #100;
        $finish;
    end
endmodule