module tester (
    output reg CLK,
    output reg VCC
   );


parameter semiCiclo = 0.5;
parameter ciclo = 1;

always
   begin
      #semiCiclo CLK=!CLK;
   end

initial
  begin   
    VCC = 1;
    CLK = 0;
    #ciclo                      
    #15
    #16
    #ciclo
    #ciclo
    #ciclo
    #15
    #16
    #ciclo
    #ciclo
    #ciclo
    $finish;
  end     

endmodule
