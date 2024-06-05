module me (clock, reset, 
s_in,valid);

input clock, reset, s_in;
output reg valid;

reg [5:0] state;
reg [2:0] count0;

reg [5:0] nxt_state;
reg [2:0] nxt_count0;           

//Ambas variables almacenadas en registros hechos con FF de flanco positivo.
// Un FF por bit de cada variable.
           
always @(posedge clock) begin
  if (reset) begin
    state  <= 6'b000001;
    count0 <= 3'b000; 
  end else begin
    state  <= nxt_state;
    count0 <= nxt_count0;
  end
end  //Fin de los flip flops

always @(*) begin

// Valores por defecto

  nxt_state = state;   //Para completar el comportamiento del FF se necesita
                       //que por defecto el nxt_state sostenga el valor del estado
                       //anterior
  nxt_count0 = count0; // Igual al caso de state y nxt_state, para garantizar el 
                       // comportamiento del FF. 
   
  valid = 1'b0;  //La salida es cero para todos los estados excepto el �ltimo, 
                 //entonces la ponemos en cero como valor por defecto 
                 //y solo se modifica si llegamos al �ltimo estado. 

// Comportamiento de la m�quina de estados
// Define las transiciones de pr�ximo estado seg�n el diagrama ASM
// visto en clase y el comportamiento de "valid" y "count0" en el 
// �ltimo estado, seg�n la especificaci�n.

  case(state)
    6'b000001: if (s_in) nxt_state = 6'b000010;    // Idle, solo salimos de este estado cuando s_in=1'b1

    6'b000010: if (~s_in) nxt_state = 6'b000100;   // 1 recibido, si se recibe un 0, pasamos al siguiente
                                                   // estado, de lo contrario, seguimos aqu�.
                                                                   
    6'b000100: begin                               // 10   recibido, si se recibe un 1, pasamos al siguiente  
                 if (s_in) nxt_state = 6'b00100;   // estado, de lo contrario volvemos a IDLE.
                 else nxt_state = 6'b000001;
               end                
               
    6'b001000: begin                               // 101  recibido, si se recibe un 0, vamos al siguiente estado.
                 if (~s_in) nxt_state = 6'b010000; // De lo contrario, volvemos al estado donde solo se recibi� un 1.   
                 else nxt_state = 6'b000010;
               end
               
    6'b010000: begin                               // 1010 recibido, si se recibe otro cero, vamos al estado final.
                 if (~s_in) nxt_state = 6'b100000; // En caso contrario, volvemos al estado donde hemos recibido 101
                 else nxt_state = 6'b001000;
               end                                                                               
               
    6'b100000: begin                               //10100 recibido, se debe encender v�lido y esperar RESET o la
                 valid = 1'b1;                     //secuencia 00000 para regresar a IDLE. En cualquier otro caso,
                 if (~s_in) nxt_count0 = count0+1; //se debe permanecer en el estado actual.
                 else nxt_count0 = 3'b000;
                 if (reset | (count0 == 3'b101)) nxt_state = 6'b000001;
               end
    default:   nxt_state = 6'b000001; // Si la m�quina entrara en un estado inesperado, regrese al inicio.
  endcase

end // Este end corresponde al always @(*) de la l�gica combinacional

endmodule

