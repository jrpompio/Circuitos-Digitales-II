module tester (/*AUTOARG*/);

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
    CLK = 1;                      
    REINICIO = 0;
    #0.01
    REINICIO = 1;
    #ciclo
    #ciclo
    REINICIO = 0;
    #ciclo
    
    $finish;
  end     

endmodule
