module tester (/*AUTOARG*/
   // Outputs
   CLK, RESET, RNW, START_STB, SDA_IN, TWOBYTE, I2C_ADDR, WR_DATA,
   // Inputs
   SDA_OUT, SDA_OE, SCL, RD_DATA
   );

output reg 
  CLK,        
  RESET,
  RNW,
  START_STB,
  SDA_IN,
  TWOBYTE;

output reg [6:0]
  I2C_ADDR; 

output reg [15:0]
  WR_DATA;

input
  SDA_OUT,
  SDA_OE,
  SCL;

input [15:0]
  RD_DATA;


parameter semiCiclo = 0.5;
parameter ciclo = 1;

always
   begin
      #semiCiclo CLK=!CLK;
   end

initial
  begin                        
    CLK = 1;                      
    RESET = 0;
    SDA_IN = 1;
    TWOBYTE = 1;
    RNW = 0;
    I2C_ADDR = 7'b0011010;
    START_STB = 0;
    WR_DATA = 16'b1010101010101110;
    #ciclo
    #ciclo
    RESET = 1;
    #5
    START_STB = 1;
    #ciclo
    #ciclo
    START_STB = 0;
    #67
    SDA_IN = 0;
    #8
    SDA_IN = 1;
    #100
    #100
    $finish;
  end     

endmodule
// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
