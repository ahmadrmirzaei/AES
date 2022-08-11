// `include "src/aes.sv"
`timescale 1ps/1ps
module aes_tb;
	reg [127:0] state = 128'hff6ec9c370a6678992b1fb90f3fd6595;
	reg [127:0] key = 128'h01010101010101010101010101010101;
	reg clk = 0; 
    reg rst = 0;
    reg en = 1;
	wire [127:0] state_out, key_out;
	wire done;

    // aes uut (clk, rst, en, state, key, done, state_out, key_out);

    always #(1) clk = ~clk;

    initial begin
        $display("aaaa");
        #1 en = 0;
        // $dumpfile("build/test.vcd");
        // $dumpvars(0);
        $display("%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n",
                state[0+:8], state[32+:8], state[64+:8], state[96+:8],
                state[8+:8], state[40+:8], state[72+:8], state[104+:8],
                state[16+:8], state[48+:8], state[80+:8], state[112+:8],
                state[24+:8], state[56+:8], state[88+:8], state[120+:8]
                );
        #2 en = 0;
        #100;
        $display("%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h",
                state_out[0+:8], state_out[32+:8], state_out[64+:8], state_out[96+:8],
                state_out[8+:8], state_out[40+:8], state_out[72+:8], state_out[104+:8],
                state_out[16+:8], state_out[48+:8], state_out[80+:8], state_out[112+:8],
                state_out[24+:8], state_out[56+:8], state_out[88+:8], state_out[120+:8]
                );
        $finish;
    end
endmodule