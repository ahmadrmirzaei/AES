`timescale 1ps/1ps
module pipeReg (
    input clk, rst, en,
	input [127:0] state, key,
    output reg done,
	output reg [127:0] state_out, key_out
);

    initial begin
        state_out <= 128'b0;
        key_out <= 128'b0;
        done <= 1'b0;
    end

    always @(posedge clk) begin
        if (rst) begin
            state_out <= 128'b0;
            key_out <= 128'b0;
            done <= 1'b0;
        end
        else begin
            state_out <= state;
            key_out <= key;
            done <= 1'b1;
            
            $display("%0t\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n", $time,
                    state[0+:8], state[32+:8], state[64+:8], state[96+:8],
                    state[8+:8], state[40+:8], state[72+:8], state[104+:8],
                    state[16+:8], state[48+:8], state[80+:8], state[112+:8],
                    state[24+:8], state[56+:8], state[88+:8], state[120+:8]
                    );
        end
    end
endmodule