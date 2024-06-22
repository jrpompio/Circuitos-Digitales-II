module spiMaster (/*AUTOARG*/
   // Outputs
   MOSI, SCK, CS,
   // Inputs
   CLK, RESET, CKP, CPH, MISO, ENABLE, DATAINPUT
   );

/*AUTOINPUT*/
input
  CLK,          // Entrada de reloj para  
  RESET,        // Señal para reiniciar la maquina de estado
  CKP,          /* CKP = 0 -> Nivel bajo inactivo
                   CKP = 1 -> Nivel alto inactivo */

  CPH,          /* Entendiendo 1 como flanco de subida 
                             y 0 como flanco de bajada 
                   CPH = 0 -> flanco activo ~CKP  
                   CPH = 1 -> flanco activo  CKP  */

  MISO,         // Master Input Slave Output

  ENABLE;       // Señal para inicar la transferencia de datos

input [7:0] 
  DATAINPUT;    // Bus de datos necesario para las pruebas del circuito

/*AUTOOUTPUT*/
output reg
  MOSI,         // Master Output Slave Input
  SCK,          /* Salida de reloj para el transmisor SPI, flanco activo es
                   el flanco creciente, 25% de la frecuencia de CLK
                   debe ser consistente con CKP y CPH*/
  CS;           /* Chip Select, es una salida del transmisor SPI que indica
                   envio de transacción hacia el receptor -> Activo en bajo*/
/*AUTOREG*/
reg [7:0] INTERNALDATA,       // 8 bits internos a transmitor por medio de MOSI
      NEXTINTERNALDATA;     
reg [1:0] DIVFREQ;            // Contador para divisor de frecuencia
reg [2:0] COUNTER;            // Contador de bits transmitidos

// ASIGNACIONES

/******************************************************************************
                              PARAMETROS DE ESTADO
 *****************************************************************************/
parameter N = 2;  // PARAMETRO PARA CANTIDAD DE ESTADOS

parameter idle = {{(N-1){1'b0}} , 1'b1}; // CONCATENANDO N-1 CEROS CON UN 1 
parameter transmit = idle << 1;

// REGISTROS INTERNO PARA MANEJO DE ESTADOS
reg [N-1:0] STATE, NEXTSTATE;

/******************************************************************************
                              COMPORTAMIENTOS
 *****************************************************************************/

always @(posedge CLK or posedge RESET) begin // LÓGICA SECUENCIAL
    
  if (!RESET) begin             
                              // RESET DE VALORES DE FF
    STATE <= idle;
    SCK = CKP;
    INTERNALDATA <= DATAINPUT;
    DIVFREQ = 0;

  end else begin              
                              // TRANSICIÓN DE ESTADOS DE FF
    STATE <= NEXTSTATE;
    DIVFREQ <= DIVFREQ+1;

    if (STATE == idle) begin
      SCK = CKP;
    end else if (STATE == transmit) begin
      SCK = DIVFREQ[1];
    end
    
  end
end

always @(*) begin   // LÓGICA COMBINACIONAL 

                              // SOSTENIENDO VALORES DE FF
NEXTSTATE = STATE;
                              // VALORES DE OUTPUTS POR DEFECTO
CS = 1;

/*CASOS PARA CADA ESTADO*/
case(STATE)
  idle: begin
    if (ENABLE) begin
    NEXTSTATE = transmit;
    end 
  end
  transmit: begin
    NEXTSTATE = idle;
  end
  default:  begin
    NEXTSTATE = idle;
  end          
endcase
end

endmodule
