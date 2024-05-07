normal: clean setTESTBnormal all rmvcd # DEFAULT
rtlil: clean setTESTBrtlil yosysRTLIL all rmvcd
synth: clean setTESTBsynth yosys all rmvcd 

BINARY = salida.vvp
TESTFILE = archivosPrueba/tester.v
TESTFILE2 = archivosPrueba/tester2.v
TESTFILE3 = archivosPrueba/tester3.v
TESTFILE4 = archivosPrueba/tester4.v

setTESTBnormal: 
		$(eval TESTB = bancosPrueba/testbenchConduc.v) 

setTESTBsynth: 
		$(eval TESTB = bancosPrueba/testbenchSynth.v) 

setTESTBrtlil: 
		$(eval TESTB = bancosPrueba/testbenchRTLIL.v) 

all: plan1 plan2 plan3 plan4

# Esta regla copila el programa, crea los vcd y ejecuta en gtkwave
plan1:$(TESTB) $(TESTFILE) # Archivos necesarios para correr esta orden.
		# EJECUTANDO PLAN 1 
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE) 
		vvp $(BINARY) 
		gtkwave ondas.gtkw

plan2:$(TESTB) $(TESTFILE2) 
		# EJECUTANDO PLAN 2
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE2)
		vvp $(BINARY)
		gtkwave ondas.gtkw

plan3:$(TESTB) $(TESTFILE3) 
		# EJECUTANDO PLAN 3
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE3)
		vvp $(BINARY)
		gtkwave ondas.gtkw

plan4:$(TESTB) $(TESTFILE4) 
		# EJECUTANDO PLAN 4
		iverilog -o $(BINARY) $(TESTB) $(TESTFILE4)
		vvp $(BINARY)
		gtkwave ondas.gtkw

# ESTA REGLA CREA LA SINTESIS CON YOSYS USANDO ABC
yosys:
		yosys synth.ys

# ESTA REGLA CREA LA SINTESIS CON YOSYS USANDO LIBRERIA INTERNA
yosysRTLIL:
		yosys synth_RTLIL.ys

# ESTA REGLA LIMPIA LOS BINARIOS Y .vcd
rmvcd:
		rm *.vvp *.vcd
		
# Esta regla elimina los archivos genrados por yosys
clean: 
		rm PM_synth* &