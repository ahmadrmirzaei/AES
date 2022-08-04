`timescale 1ps/1ps
module rCon (
    input [3:0] r,
    output reg [31:0] rcon
);

    always @(*) begin
        case(r)
        4'h1: rcon=32'h00000001;
        4'h2: rcon=32'h00000002;
        4'h3: rcon=32'h00000004;
        4'h4: rcon=32'h00000008;
        4'h5: rcon=32'h00000010;
        4'h6: rcon=32'h00000020;
        4'h7: rcon=32'h00000040;
        4'h8: rcon=32'h00000080;
        4'h9: rcon=32'h0000001b;
        4'ha: rcon=32'h00000036;
        default: rcon=32'h00000000;
        endcase
    end
endmodule