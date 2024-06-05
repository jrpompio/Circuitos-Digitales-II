module tester (/*AUTOARG*/
   // Outputs
   CLK, REINICIO, ARRANQUE, MODO,
   // Inputs
   MOTOR1, MOTOR2
   );

output reg CLK;
output reg REINICIO;
output reg ARRANQUE;
output reg MODO;
/*AUTOOUTPUT*/
input MOTOR1;
input MOTOR2;


parameter semiCiclo = 0.5;
parameter ciclo = 1;

always
   begin
      #semiCiclo CLK=!CLK;
   end

initial
  begin                                       
    CLK = 0;                      
    REINICIO = 1;
    #ciclo
    #ciclo
    REINICIO = 0;
    #ciclo
    ARRANQUE = 1;
    MODO = 1;
    #ciclo
    #100
    $finish;
  end     

endmodule
