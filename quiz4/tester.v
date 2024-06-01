module tester (/*AUTOARG*/
   // Outputs
   clk, reset, Switch,
   // Inputs
   gate
   );

output reg clk;
output reg reset;
output reg Switch;
input gate;


parameter semiCiclo = 0.5;
parameter ciclo = 1;

always
   begin
      #semiCiclo clk=!clk;
   end

initial
  begin                                       
    clk = 1;                      
    reset = 1;
    #0.01
    reset = 0;
    #ciclo
    #ciclo
    reset = 1;
    #ciclo
    $finish;
  end     

endmodule
