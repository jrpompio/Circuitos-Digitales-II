module tester (/*AUTOARG*/
   // Outputs
   CLK, RESET, CKP, CPH, MISO, ENABLE, DATAINPUT,
   // Inputs
   MOSI, SCK, CS
   );


/*AUTOOUTPUT*/
output reg CLK, RESET, CKP, CPH, MISO, ENABLE;
output reg [7:0] DATAINPUT;
/*AUTOINPUT*/
input MOSI, SCK, CS;

parameter semiCiclo = 0.5;
parameter ciclo = 1;

always
   begin
      #semiCiclo CLK=!CLK;
   end

initial
  begin                        
    CLK = 0;                      
    RESET = 0;
    CKP = 0;
    CPH = 0;
    DATAINPUT = 8'b11111111;
    #ciclo
    ENABLE = 1;
    #ciclo
    RESET = 1;
    #ciclo
    ENABLE = 0;
    #70
    $finish;
  end     

endmodule
// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
