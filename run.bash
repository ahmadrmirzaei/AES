iverilog '-Wall' '-g2012' -o build/sim src/testbench.sv
vvp build/sim
gtkwave build/test.vcd