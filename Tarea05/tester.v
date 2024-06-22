module tester (/*AUTOARG*/
   // Outputs
   CLK, RESET, RNW, START_STB, SDA_IN, I2C_ADDR, I2CS_ADDR,
   I2CS2_ADDR, WR_DATA, RDS_DATA, RDS2_DATA,
   // Inputs
   SDA_OUT, SDA_OE, SCL, RD_DATA, WRS_DATA, WRS2_DATA
   );

output reg 
  CLK,        
  RESET,
  RNW,
  START_STB;

output reg [6:0]
  I2C_ADDR, 
  I2CS_ADDR,
  I2CS2_ADDR; 

output reg [15:0]
  WR_DATA,
  RDS_DATA,
  RDS2_DATA;

input
  SDA_IN,
  SDA_OUT,
  SDA_OE,
  SCL;

input [15:0]
  RD_DATA,
  WRS_DATA,
  WRS2_DATA;

parameter semiCiclo = 0.5;
parameter ciclo = 1;

always
   begin
      #semiCiclo CLK=!CLK;
   end

// always @(posedge SDA_OUT) begin
//   if (SCL) begin
//     $display("2 BYTE MAIN %H", WR_DATA) ;
//     $display("2 BYTE SEC %H", WRS_DATA) ;
//   if (WR_DATA == WRS_DATA) begin
//     $display("ESCRITURA VALIDA") ;
//   end else begin
//     $display("ESCRITURA FALLIDA") ;
//   end
//   end
// end


initial
  begin                        
    CLK = 1;                      
    RESET = 0;
    RNW = 0;
    I2C_ADDR = 7'b0011010;
    I2CS_ADDR = 7'b0011010;
    I2CS2_ADDR = 7'b0011110;
    START_STB = 0;
    WR_DATA = 16'b1010101010101101;
    RDS_DATA = 16'b1110111011101101;
    #ciclo
    RESET = 1;
    #1
    START_STB = 1;
    #ciclo
    #ciclo
    START_STB = 0;
    #124;
    START_STB = 1;
    #ciclo
    #ciclo
    START_STB = 0;
    // CAMBIOS DE DATOS
    #2
    // TIEMPO PARA TRANSFERENCIA
    #124;

    $display("Terminating simulation...");

    $finish;
  end     

endmodule 
// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
