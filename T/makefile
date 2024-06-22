all:
	iverilog testbench.v -o salida.exe
	./salida.exe
	rm salida.exe &
	gtkwave ondas.gtkw
	rm ondas.vcd &
	exit
