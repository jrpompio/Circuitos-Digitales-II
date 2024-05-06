all:
		yosys synth.ys
		#
		#
		#
		#
		#
		iverilog -o salida.vvp testbench.v 
		vvp salida.vvp 
		gtkwave ondas.gtkw
		rm salida.vvp ondas.vcd
