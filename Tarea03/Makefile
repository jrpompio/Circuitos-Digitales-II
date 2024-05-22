TT_DIR = pruebas
TB_DIR = bancos

TT1 = tester.v
TT2 = tester2.v
TT3 = tester3.v

TBnormal = testbench.v
TBsynth = testbench2.v

# Por defecto se tiene el plan 2, que corresponde a retiro
# y usando el testbench para modulo sintetizado

all: copile5 run


copile: 
	iverilog $(TB_DIR)/$(TBnormal) $(TT_DIR)/$(TT1) -o salida.vvp
copile2: 
	iverilog $(TB_DIR)/$(TBnormal) $(TT_DIR)/$(TT2) -o salida.vvp
copile3: 
	iverilog $(TB_DIR)/$(TBnormal) $(TT_DIR)/$(TT3) -o salida.vvp

copile4: 
	iverilog $(TB_DIR)/$(TBsynth) $(TT_DIR)/$(TT1) -o salida.vvp
copile5: 
	iverilog $(TB_DIR)/$(TBsynth) $(TT_DIR)/$(TT2) -o salida.vvp
copile6: 
	iverilog $(TB_DIR)/$(TBsynth) $(TT_DIR)/$(TT3) -o salida.vvp

yosys: 
	yosys *.ys

run:
	vvp salida.vvp
	gtkwave ondas.gtkw
	rm salida.vvp ondas.vcd &
