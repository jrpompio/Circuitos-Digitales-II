all: plan1 # escoger opción default

BINARY = salida.vvp
TESTFILE = archivosPrueba/tester.v
TESTFILE2 = archivosPrueba/tester2.v
TESTFILE3 = archivosPrueba/tester3.v
TESTFILE4 = archivosPrueba/tester4.v

# Esta regla copila el programa, crea los vcd y ejecuta en gtkwave
plan1: testbench.v $(TESTFILE) # Archivos necesarios para correr esta orden.
		iverilog -o $(BINARY) testbench.v $(TESTFILE) 
		vvp $(BINARY) 
		gtkwave ondas.gtkw
		make clean

plan2: testbench.v $(TESTFILE2) 
		iverilog -o $(BINARY) testbench.v $(TESTFILE2)
		vvp $(BINARY)
		gtkwave ondas.gtkw
		make clean

plan3: testbench.v $(TESTFILE3) 
		iverilog -o $(BINARY) testbench.v $(TESTFILE3)
		vvp $(BINARY)
		gtkwave ondas.gtkw
		make clean

plan4: testbench.v $(TESTFILE4) 
		iverilog -o $(BINARY) testbench.v $(TESTFILE4)
		vvp $(BINARY)
		gtkwave ondas.gtkw
		make clean

clean:
		rm $(BINARY) ondas.vcd
