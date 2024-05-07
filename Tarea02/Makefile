synth: setTESTBsynth yosys all # DEFAULT
normal: setTESTBnormal all

BINARY = salida.vvp
TESTFILE = archivosPrueba/tester.v
TESTFILE2 = archivosPrueba/tester2.v
TESTFILE3 = archivosPrueba/tester3.v
TESTFILE4 = archivosPrueba/tester4.v

setTESTBnormal: 
		$(eval TESTB = bancosPrueba/testbenchConduc.v) 
setTESTBsynth: 
		$(eval TESTB = bancosPrueba/testbenchSynth.v) 

all: plan1 plan2 plan3 plan4

# Esta regla copila el programa, crea los vcd y ejecuta en gtkwave
plan1:$(TESTB) $(TESTFILE) # Archivos necesarios para correr esta orden.
		# EJECUTANDO PLAN 1 
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE) 
		vvp $(BINARY) 
		gtkwave ondas.gtkw
		make clean

plan2:$(TESTB) $(TESTFILE2) 
		# EJECUTANDO PLAN 2
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE2)
		vvp $(BINARY)
		gtkwave ondas.gtkw
		make clean

plan3:$(TESTB) $(TESTFILE3) 
		# EJECUTANDO PLAN 3
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE3)
		vvp $(BINARY)
		gtkwave ondas.gtkw
		make clean

plan4:$(TESTB) $(TESTFILE4) 
		# EJECUTANDO PLAN 4
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE4)
		vvp $(BINARY)
		gtkwave ondas.gtkw
		make clean

# ESTA REGLA CREA LA SINTESIS CON YOSYS
yosys:
		yosys synth.ys
# ESTA REGLA LIMPIA LOS BINARIOS Y .vcd
clean:
		rm $(BINARY) ondas.vcd
