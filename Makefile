# ======== MAKE FILE ========

#Source and testbench files

SRC = src/dual_port_sram.v
TB = tb/tb_dual_port_sram.v
OUT = sim/dual_port_sram
VCD = sim/dual_port_sram.vcd
NETLIST = output/dual_port_sram_netlist.v

sim: 
	@mkdir -p sim
	iverilog -g2005-sv -o $(OUT) $(SRC) $(TB)
	vvp $(OUT)

wave:
	gtkwave $(VCD)

synth: 
	@mkdir -p output
	yosys -q -p "read_verilog $(SRC); hierarchy -top dual_port_sram; snyth -topdual_port_sram; write_verilog $(NETLIST)"

clean: 
	rm -rf sim/*.vcd sim/dual_port_sram output/*.v

# ALL (sim + wave)
all: sim wave

