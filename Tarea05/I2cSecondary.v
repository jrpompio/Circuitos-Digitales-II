module I2cSecondary  (/*AUTOARG*/
   // Outputs
   SDA_IN, WRS_DATA,
   // Inputs
   CLK, RESET, SDA_OUT, SDA_OE, SCL, RDS_DATA, I2CS_ADDR
   );
   
/*AUTOINPUT*/
input
  CLK,
  RESET,
  SDA_OUT,
  SDA_OE,
  SCL;

input [15:0]
  RDS_DATA;

input [6:0]
  I2CS_ADDR; 

/*AUTOOUTPUT*/

output reg
  SDA_IN;

output reg [15:0]
  WRS_DATA; 

/*AUTOREG*/

reg [7:0]
  HI, 
  LO,
  ADDR_RNW_S;


reg [2:0] 
  INDEX,
  NEXT_INDEX;

reg [3:0]
  NINE_COUNTER,
  NEXT_NC;

reg
  START,
  LAST_SDA,
  LAST_SCL,
  TIH,
  NEXT_TIH;
  
wire
  CURRENT_SDA,
  POSEDGE_SDA,
  NEGEDGE_SDA,
  POSEDGE_SCL,
  NEGEDGE_SCL;
  
assign POSEDGE_SCL = !LAST_SCL && SCL;
assign NEGEDGE_SCL = LAST_SCL && !SCL;

assign POSEDGE_SDA = !LAST_SDA && CURRENT_SDA;
assign NEGEDGE_SDA = LAST_SDA && !CURRENT_SDA;

assign CURRENT_SDA = SDA_IN && SDA_OUT;

/******************************************************************************


/******************************************************************************
                              PARAMETROS DE ESTADO
 *****************************************************************************/
parameter N = 6;  // PARAMETRO PARA CANTIDAD DE ESTADOS

parameter standby = {{(N-1){1'b0}} , 1'b1}; // CONCATENANDO N-1 CEROS CON UN 1 
parameter address = standby << 1;
parameter await = standby << 2;
parameter stop = standby << 3;
parameter write = standby << 4;
parameter read  = standby << 5;

// REGISTROS INTERNO PARA MANEJO DE ESTADOS
reg [N-1:0] state, nextState;

/******************************************************************************
                              COMPORTAMIENTOS
 *****************************************************************************/

always @(posedge CLK) begin // LÓGICA SECUENCIAL
  if (!RESET) begin             
                              // RESET DE VALORES DE FF
    state <= standby;
    SDA_IN <= 1;
    START <= 0;
    LAST_SCL <= 1;
    LAST_SDA <= 1;
    ADDR_RNW_S <= 0;
    TIH <= 1'h0;
    HI <= 0;
    LO <= 0;
    NINE_COUNTER = 0;
    WRS_DATA = 0;

  /*AUTORESET*/
  // Beginning of autoreset for uninitialized flops
  INDEX <= 3'h0;
  // End of automatics

  end else begin              
                              // TRANSICIÓN DE ESTADOS DE FF
    LAST_SCL <= SCL;
    LAST_SDA <= CURRENT_SDA;
    state <= nextState;    
    INDEX <= NEXT_INDEX;  
    TIH <= NEXT_TIH;
    NINE_COUNTER <= NEXT_NC;

    if (NEGEDGE_SDA && SCL) begin
      START <= 1;
    end else if (POSEDGE_SDA && SCL) begin
      START <=0;
    end

    if (state == standby) begin
          HI <= 8'h0;
          LO <= 8'h0;
          TIH <= 1;
    end  
  end
end

always @(*) begin   // LÓGICA COMBINACIONAL 

                              // SOSTENIENDO VALORES DE FF
nextState = state;
NEXT_INDEX = INDEX;
NEXT_TIH = TIH;
NEXT_NC = NINE_COUNTER;

// ESTADOS QUE NO SEAN stanby o stop
if (~((state == standby) || (state == stop))) begin
  if (POSEDGE_SCL) begin
    NEXT_NC = NINE_COUNTER+1;
    if (NINE_COUNTER == 8 ) NEXT_NC = 0;
  end
// CASO CONTRARIO
end else begin
    NEXT_NC = 0;
end

                              // VALORES DE OUTPUTS POR DEFECTO
SDA_IN = 1;
/*CASOS PARA CADA ESTADO*/
case(state)
  standby: begin
    if (START) begin
      nextState = address;
    end
  end

  address: begin
    if (POSEDGE_SCL) begin
        ADDR_RNW_S[7-INDEX] = SDA_OUT;
      if (~(INDEX == 7)) begin
        NEXT_INDEX = INDEX+1;
      end
    end

    if (NEGEDGE_SCL) begin
      if ((NINE_COUNTER == 8)) nextState = await;
      // if (INDEX == 7) NEXT_DELAY = 1;
      // if (DELAY) nextState = await;
    end

   end

  await: begin
    NEXT_INDEX = 0;
    if (ADDR_RNW_S[7:1] == I2CS_ADDR)
    begin
      SDA_IN = 0;
      if (NEGEDGE_SCL) begin
      nextState = ADDR_RNW_S[0] ? read : write;
      end
    end else begin
      nextState = stop;
      SDA_IN = 1;
    end
  
  end

  stop: begin
    if (~START) nextState = standby;
  end

  read: begin

  end

  write: begin
    if (NEGEDGE_SCL) begin
      if (TIH) begin
        HI[7-INDEX] = SDA_OUT;
      end else begin
        LO[7-INDEX] = SDA_OUT;
      end

      if (INDEX == 7) begin
        if (TIH) begin
          nextState = await;
        end else begin
          WRS_DATA = {HI, LO};
          nextState = stop;
        end
        NEXT_TIH = 0;
      end else begin
        NEXT_INDEX = INDEX+1;
      end
    end


  end
  

  default:  begin
  end          
endcase
end

endmodule
