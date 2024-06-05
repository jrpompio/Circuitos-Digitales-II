module quiz4 (/*AUTOARG*/
   // Outputs
   MOTOR1, MOTOR2,
   // Inputs
   CLK, REINICIO, ARRANQUE, MODO
   );

/*AUTOINPUT*/
input CLK;
input REINICIO;
input ARRANQUE;
input MODO;
/*AUTOOUTPUT*/
output reg MOTOR1;
output reg MOTOR2;
/*AUTOREG*/
reg [5:0] BATERIA;
reg [5:0] NEXTBATERIA;
reg [5:0] TANQUE;
reg [5:0] NEXTTANQUE;

/******************************************************************************
                              PARAMETROS DE ESTADO
 *****************************************************************************/
parameter N = 4;  // PARAMETRO PARA CANTIDAD DE ESTADOS

parameter INICIO = {{(N-1){1'b0}} , 1'b1}; // CONCATENANDO N-1 CEROS CON UN 1 
parameter GAS = INICIO << 1;
parameter ELECTRICO = GAS << 1;
parameter FIN = ELECTRICO << 1;

// REGISTROS INTERNO PARA MANEJO DE ESTADOS
reg [N-1:0]state;
reg [N-1:0]nextState;

/******************************************************************************
                              COMPORTAMIENTOS
 *****************************************************************************/
always @(posedge CLK) begin // LÓGICA SECUENCIAL
  if (REINICIO) begin             
                              // REINICIO DE VALORES DE FF
  /*AUTORESET*/
  // Beginning of autoreset for uninitialized flops
  BATERIA <= 0;
  TANQUE <= 0;
  state <= INICIO;
  // End of automatics

  end else begin              
                              // TRANSICIÓN DE ESTADOS DE FF
    state <= nextState;       
    BATERIA <= NEXTBATERIA ;       
    TANQUE <= NEXTTANQUE;       
  end
end

always @(*) begin   // LÓGICA COMBINACIONAL 

                              // SOSTENIENDO VALORES DE FF
nextState = state;
NEXTBATERIA = BATERIA;
NEXTTANQUE = TANQUE;
                              // VALORES DE OUTPUTS POR DEFECTO
MOTOR1 = 0;
MOTOR2 = 0;


/*CASOS PARA CADA ESTADO*/
case(state)
  INICIO: begin
            if (ARRANQUE && MODO) begin
              nextState = GAS;
            end else if (ARRANQUE && ~MODO) begin
              nextState = ELECTRICO;
            end 
          end
  GAS: begin
          NEXTTANQUE = TANQUE+1;      // aumentando contador del tanque
          MOTOR2 = 1;                 // Se enciende motor 2
          if (BATERIA == 20) begin
            nextState = FIN;
          end
  end

  ELECTRICO: begin
          NEXTBATERIA = BATERIA+1;    // aumentando contador de bateria
          MOTOR1 = 1;                 // se enciende motor 1
          if (TANQUE == 15) begin
            nextState = FIN;
          end
  end
  FIN: begin
          MOTOR1 = 1;     // Se encienden ambos motores
          MOTOR2 = 1;
  end
  default:  begin
            nextState = INICIO; // si ocurre un estado no deseado
                                // se dirige a estado INICIO
            end          
endcase
end

endmodule
