// FONDOS INSUFICIENTES y RETIRO
`timescale 100 ms / 1 ms  // time-unit = 100ms , precision = 10 ms
module tester (/*AUTOARG*/
   // Outputs
   clk, reset, TARJETA_RECIBIDA, DIGITO_STB, TIPO_TRANS, MONTO_STB,
   ENTER_PIN, ERASE_PIN, PIN, DIGITO, MONTO, FONDOS,
   // Inputs
   BALANCE_ACTUALIZADO, ENTREGAR_DINERO, FONDOS_INSUFICIENTES,
   PIN_INCORRECTO, ADVERTENCIA, BLOQUEO
   );

input BALANCE_ACTUALIZADO, ENTREGAR_DINERO, FONDOS_INSUFICIENTES,
   PIN_INCORRECTO, ADVERTENCIA, BLOQUEO;
   
output reg clk, reset, TARJETA_RECIBIDA, DIGITO_STB, TIPO_TRANS, MONTO_STB, 
  ENTER_PIN, ERASE_PIN;

output reg [15:0] PIN;
output reg [3:0] DIGITO;
output reg [31:0] MONTO;
output reg [63:0] FONDOS;

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
    TARJETA_RECIBIDA = 1;                   //                   
    DIGITO_STB = 0;                         //
    TIPO_TRANS = 1;                         //  Valores iniciales             
    MONTO_STB = 0;                          //  para entradas
    ENTER_PIN = 0;                          //
    ERASE_PIN = 0;                          //
    PIN = 16'b1001100001110100;             //                         
    MONTO = 0;                              //
    FONDOS = 64'b10000000000000;            //                                   
    #0.1
      reset = 0;
    #ciclo
      reset = 1;              //
    #ciclo      
      DIGITO = 4'b1001;       //  PRIMER DIGITO                  
      DIGITO_STB = 1;                            
    #ciclo
      DIGITO_STB = 0;         //                
    #ciclo
      DIGITO = 4'b1000;       //  SEGUNDO DIGITO      
      DIGITO_STB = 1;                  
    #ciclo
      DIGITO_STB = 0;         //                
    #ciclo
      DIGITO = 4'b0111;       //  TERCER DIGITO     
      DIGITO_STB = 1;                  
    #ciclo
      DIGITO_STB = 0;         //                
    #ciclo
      DIGITO = 4'b0100;       //  CUARTO DIGITO         
      DIGITO_STB = 1;                  
    #ciclo
      DIGITO_STB = 0;         //       
    #ciclo
      ENTER_PIN = 1;          // TECLA ENTER
    #ciclo
      ENTER_PIN = 0;          //                  
    #ciclo
      MONTO = 21725;
      MONTO_STB = 1;  
    #ciclo
      MONTO_STB = 0;
    #ciclo
      ENTER_PIN = 1;
    #ciclo
     ENTER_PIN = 0;
    #ciclo
      MONTO = 7000;
      MONTO_STB = 1;  
    #ciclo
      MONTO_STB = 0;
    #ciclo
      ENTER_PIN = 1;
    #ciclo
     ENTER_PIN = 0;
     TARJETA_RECIBIDA = 0;
    #ciclo
      reset = 0;
    #ciclo
      reset = 1;
    #ciclo
    $finish;
  end     

endmodule
