
module tester (/*AUTOARG*/
   // Outputs
   CLK, RESET, RNW, START_STB, I2C_ADDR, I2CS_ADDR, WR_DATA,
   RDS_DATA,
   // Inputs
  SCL, RD_DATA, WRS_DATA
   );

output reg 
  CLK,        
  RESET,
  RNW,
  START_STB,
  SDA_IN;

output reg [6:0]
  I2C_ADDR, 
  I2CS_ADDR; 

output reg [15:0]
  WR_DATA,
  RDS_DATA;

input
  SDA_OUT,
  SDA_OE,
  SCL;

input [15:0]
  RD_DATA,
  WRS_DATA;


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
    RNW = 0;
    I2C_ADDR = 7'b0011010;
    I2CS_ADDR = 7'b0011010;
    START_STB = 0;
    WR_DATA = 16'b1010101010101101;
    #ciclo
    #ciclo
    RESET = 1;
    #3
    START_STB = 1;
    #ciclo
    #ciclo
    START_STB = 0;
    #500
    
    $display("Terminating simulation...");
    $finish;
  end     

endmodule
// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
