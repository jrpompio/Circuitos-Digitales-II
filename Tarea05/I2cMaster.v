module I2cMaster (/*AUTOARG*/
   // Outputs
   SDA_OUT, SDA_OE, RD_DATA, SCL,
   // Inputs
   CLK, RESET, RNW, START_STB, SDA_IN, TWOBYTE, I2C_ADDR, WR_DATA
   );

/*AUTOINPUT*/
input
  CLK,        
  RESET,
  RNW,
  START_STB,
  SDA_IN,
  TWOBYTE;

input [6:0]
  I2C_ADDR; 

input [15:0]
  WR_DATA;

/*AUTOOUTPUT*/
output reg
  SDA_OUT,
  SDA_OE;

output reg [15:0]
  RD_DATA;

output wire
  SCL;

/*AUTOREG*/
reg [7:0]
  HI, 
  LO,
  ADDR_RNW;


reg [2:0] 
  INDEX,
  NEXT_INDEX;

reg [1:0]
  SLOW_CLOCK;

reg
  START,
  LAST_SDA,
  LAST_SCL,
  TIH;
  
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

assign SCL = SLOW_CLOCK[1];

assign CURRENT_SDA = SDA_IN && SDA_OUT;

/******************************************************************************


/******************************************************************************
                              PARAMETROS DE ESTADO
 *****************************************************************************/
parameter N = 5;  // PARAMETRO PARA CANTIDAD DE ESTADOS

parameter standby = {{(N-1){1'b0}} , 1'b1}; // CONCATENANDO N-1 CEROS CON UN 1 
parameter address = standby << 1;
parameter await = standby << 2;
parameter read  = standby << 3;
parameter write = standby << 4;

// REGISTROS INTERNO PARA MANEJO DE ESTADOS
reg [N-1:0] state, nextState;

/******************************************************************************
                              COMPORTAMIENTOS
 *****************************************************************************/

always @(posedge CLK) begin // LÓGICA SECUENCIAL
  if (!RESET) begin             
                              // RESET DE VALORES DE FF
    state <= standby;
    SDA_OUT <= 1;
    START <= 0;
    SLOW_CLOCK <= 2'b11;
    LAST_SCL <= 1;
    LAST_SDA <= 1;
    ADDR_RNW <= {I2C_ADDR, 1'b1 /*RNW*/};
    RD_DATA = 0;

  /*AUTORESET*/
  // Beginning of autoreset for uninitialized flops
  HI <= 8'h0;
  INDEX <= 3'h0;
  LO <= 8'h0;
  TIH <= 1'h0;
  // End of automatics

  end else begin              
                              // TRANSICIÓN DE ESTADOS DE FF
    LAST_SCL <= SCL;
    LAST_SDA <= CURRENT_SDA;
    state <= nextState;    
    INDEX <= NEXT_INDEX;  

    if (START_STB) begin
      SDA_OUT <= 0;

      {HI, LO} = WR_DATA;

      if (TWOBYTE) begin
        TIH <= 1;
      end
    
    end 

    if (NEGEDGE_SDA && SCL) begin
      START <= 1;
    end else if (POSEDGE_SDA && SCL) begin
      START <=0;
    end

    if (START) begin
      SLOW_CLOCK <= SLOW_CLOCK+1;
    end

  
  end
end

always @(*) begin   // LÓGICA COMBINACIONAL 

                              // SOSTENIENDO VALORES DE FF
nextState = state;
NEXT_INDEX = INDEX;
                              // VALORES DE OUTPUTS POR DEFECTO
SDA_OE = 1;

/*CASOS PARA CADA ESTADO*/
case(state)
  standby: begin
    START = 0;
    if (START_STB) begin
    nextState = address;
    end
  end
  address: begin
      if (NEGEDGE_SCL && START) begin
      SDA_OUT = ADDR_RNW[7-INDEX];
      if (INDEX == 7) begin
         nextState = await;
      end else begin
      NEXT_INDEX = INDEX+1;
      end
      end
  end
  await: begin
  NEXT_INDEX = 0;
  SDA_OE = 0;
    if (NEGEDGE_SCL) begin 
    SDA_OUT = 1;
    end else begin
      if (~SDA_IN) begin
      nextState = RNW ? read : write;
      end
    end
  end

  read: begin

  end

  write: begin
    if (NEGEDGE_SCL && START) begin
    if (TWOBYTE) begin
      SDA_OUT = HI[7-INDEX];
    end else begin
      SDA_OUT = LO[7-INDEX];
    end
    if (INDEX == 7) begin
      nextState = await;
    end else begin
    NEXT_INDEX = INDEX+1;
    end
    end

    if (~SDA_IN) NEXT_INDEX = 0;  

  end
  

  default:  begin
  end          
endcase
end

endmodule
