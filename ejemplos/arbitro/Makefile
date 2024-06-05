all: copile run clean

copile: testbench.v
	yosys arbiter.ys
	iverilog -o salida.exe testbenchS.v
run: salida.exe
	./salida.exe
	gtkwave resultados.gtkw

.PHONY: clean
clean:
	rm salida.exe resultados.vcd &

