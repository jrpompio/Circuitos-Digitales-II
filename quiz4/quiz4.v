module quiz4 (/*AUTOARG*/);

/*AUTOINPUT*/
input clk;
input reset;
/*AUTOOUTPUT*/
/*AUTOREG*/



/******************************************************************************
                              PARAMETROS DE ESTADO
 *****************************************************************************/
parameter N = 3;  // PARAMETRO PARA CANTIDAD DE ESTADOS

parameter idle = {{(N-1){1'b0}} , 1'b1}; // CONCATENANDO N-1 CEROS CON UN 1 
parameter estado = idle << 1;
parameter estado2 = estado << 1;

// REGISTROS INTERNO PARA MANEJO DE ESTADOS
reg [N-1:0]state;
reg [N-1:0]nextState;

/******************************************************************************
                              COMPORTAMIENTOS
 *****************************************************************************/
always @(posedge clk) begin // LÓGICA SECUENCIAL
  if (!reset) begin             
                              // REINICIO DE VALORES DE FF
  /*AUTORESET*/
  // Beginning of autoreset for uninitialized flops
  state <= idle;
  // End of automatics

  end else begin              
                              // TRANSICIÓN DE ESTADOS DE FF
    state <= nextState;       
  end
end

always @(*) begin   // LÓGICA COMBINACIONAL 

                              // SOSTENIENDO VALORES DE FF
nextState = state;
                              // VALORES DE OUTPUTS POR DEFECTO

/*CASOS PARA CADA ESTADO*/
case(state)
  idle: begin
        nextState = idle;
        end
  default:  begin
            nextState = idle;
            end          
endcase
end

endmodule
