`timescale 1ps/1ps
module pipeReg (
    input clk, rst, en,
	input [127:0] in,
	output reg [127:0] out,
    output reg done
);

    initial out <= 1'b0;
    initial done <= 1'b0;

    always @(posedge clk) begin

        if (rst) begin
            out <= 128'b0;
            done <= 1'b0;
        end
        else if (en) begin
            out <= in;
            done <= 1'b1;
            $display("%0t\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n%h %h %h %h\n", $time,
                    in[0+:8], in[32+:8], in[64+:8], in[96+:8],
                    in[8+:8], in[40+:8], in[72+:8], in[104+:8],
                    in[16+:8], in[48+:8], in[80+:8], in[112+:8],
                    in[24+:8], in[56+:8], in[88+:8], in[120+:8]
                    );
        end

        else
            done <= 0;
    end
endmodule