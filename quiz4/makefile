all: copile run

copile:
	iverilog testbench.v -o salida.exe
	./salida.exe
run:
	gtkwave ondas.gtkw
