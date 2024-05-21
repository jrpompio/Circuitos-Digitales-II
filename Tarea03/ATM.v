/**************************************************************************//**
 * @file ATM.v
 * @brief Tarea03 de Circuitos Digitales II - Controlador de cajero automatico
 * 
 * Estudiante: Junior Ruiz Sánchez
 * Carnet: B97206
 * Mediante la implementación de una máquina de estados este controlador
 * gestiona todo lo relacionado las operaciones de un cajero automatico
 * como lo pueden ser autentificación, depositos y retiros.
 * 
 *****************************************************************************/

/**************************************************************************//**
 * @brief Controlador de cajero automatico
 *****************************************************************************/
module ATM (/*AUTOARG*/
   // Outputs
   BALANCE_ACTUALIZADO, ENTREGAR_DINERO, FONDOS_INSUFICIENTES,
   PIN_INCORRECTO, ADVERTENCIA, BLOQUEO,
   // Inputs
   clk, reset, TARJETA_RECIBIDA, PIN, ERASE_PIN, FONDOS, DIGITO,
   DIGITO_STB, ENTER_PIN, TIPO_TRANS, MONTO, MONTO_STB
   );

/* Se procederá a declarar las entradas usando input para cada una de ellas
 * debido a que estoy probado si puedo lograr documentar con Doxygen, 
 * lo mismo para outputs y regs.
 * Aún no estoy seguro si es la manera correcta, si encuento una mejor manera
 * lo cambiaré
 */

/******************************************************************************
 *     DECLARACIÓN DE ENTRADAS, SALIDAS y REGISTROS INTERNOS.
 *****************************************************************************/

input clk;                 /**< Señal de reloj para sinconizar el modulo */

input reset;               /**< Señal de reinicio, reinicia en reset = 0 */

input TARJETA_RECIBIDA;    /**< Señal de entraba binaria que indica si se ha
                                introducido una tarjeta valida*/

input [15:0] PIN;          /**< Entrada de 16 bits donde cada grupo de 4 bits 
                                representa un digito del PIN de la tarjeta que
                                se recibió*/
input ERASE_PIN;           /**< Entrada binaria usada para reiniciar el PIN
                                digitado por el usuario en el cajero */

input [63:0] FONDOS;       /**< Entrada de 64 bits que recibe la maquina de 
                                estados para conocer el balance del usuario  */

input [3:0] DIGITO;        /**< Entrada de 4 bits que representa el último 
                                dígito tecleado por el usuario, mantiene 
                                su valor anterior hasta que se preciona
                                la tecla siguiente*/

input DIGITO_STB;          /**< Señal de entrada que se pone en 1 durante
                                un solo ciclo de reloj, cuando se preciona
                                un botón del teclado. La lectura de PIN se debe
                                comparar con los valores de entrada DIGITO
                                cuando DIGITO_STB=1*/

input ENTER_PIN;           /**< Señal para enviar el PIN ingresado
                                para validar si es el PIN correcto
                                cuando ENTER_PIN = 1                */

input TIPO_TRANS;          /**< Entrada binaria que indica el tipo de
                                transacción.
                                TIPO_TRANS=0 --> depósito
                                TIPO_TRANS=1 --> retiro     */

input [31:0] MONTO;        /**< Entrada de 32 bits que representa el monto
                                de la transacción expresado en binario*/

input MONTO_STB;           /**< Señal de entrada que se pone en 1 durante un
                                solo ciclo de reloj, cuando se ha actualizado
                                el valor del MONTO a través del teclado*/

output reg 
BALANCE_ACTUALIZADO;       /**< Salida de un bit para indicar que una
                                transacción fue exitosa y que se actualizó el
                                balance en la cuenta, tanto para depósitos como
                                para retiros.*/
output reg
ENTREGAR_DINERO;           /**< Salida de un bit para indicarle al cajero que
                                entregue el monto durante una transacción de
                                retiro */
output reg
FONDOS_INSUFICIENTES;      /**< Señal de alerta cuando, durante un retiro,
                                el valor de BALANCE es menor que el valor
                                de MONTO  */
output reg
PIN_INCORRECTO;            /**< Señal que indica que el valor del PIN recibido
                                a través del teclado es distinto del PIN de
                                la tarjeta especificado en la entrada PIN*/

output reg
ADVERTENCIA;               /**< Salida binaria que se enciende cuando el
                                usuario ha introducido el PIN de forma
                                incorrecta dos veces  */
output reg
BLOQUEO;                   /**< Salida binaria que se enciende cuando el 
                                usuario ha introducido el pin de forma
                                incorrecta tres veces */

reg [63:0] BALANCE;        /**< Registro interno de 64 bits que representa
                                el balance existente en la cuenta usuario */

reg [63:0] nextBALANCE;        /**< Registro interno de 64 bits para gestionar
                                el balance del usuario*/

reg [1:0] INTENTOS;        /**< Registro interno de 2 bits que representa la 
                                cantidad de intentos usados por el usuario
                                al introducir el PIN de su tarjeta.
                                2 intentos --> enciende ADVERTENCIA
                                3 intentos --> enciende BLOQUEO */

reg PIN_CORRECTO;          /**< Registro interno que tiene valor 1 cuando la 
                                validación de PIN es correcta. */

reg nextPIN_CORRECTO;          /**< Registro interno que tiene valor 1 cuando la*/ 

reg [1:0] nextINTENTOS;    /*   Registro para gestión de cantidad de intentos*/

reg [15:0] INPUT_PIN;      /*   Registro para sostener temporalmente el PIN
                                ingresado completo */
reg [15:0] nextINPUT_PIN;      /*   Registro para sostener temporalmente el PIN */

reg [31:0] TEMP_MONTO;    /*   Registro para sostener temporalmente el
                                monto a depositar o retirar    */
                                
/******************************************************************************
 *             Uso de parametros para definir estados 
 *   y declaración de registros para gestionar estado actual y futuro
 *****************************************************************************/

parameter standby    = 5'b1;        // Estado de espera
parameter validacion = 5'b10;       // Estado de gestión de pin
parameter deposito   = 5'b100;      // Estado para transacción de deposito
parameter retiro     = 5'b1000;     // Estado para transacción de retiuro
parameter bloqueo    = 5'b10000;    // Estado en caso de pin incorrecto 3 veces

reg [4:0] state;                    // Registro para estado actual
reg [4:0] nextState;                // Registro para estado futuro

/******************************************************************************
 *                          Comportamientos
 *****************************************************************************/

always @(posedge clk) begin      // Acciones en flanco alto
  if (!reset) begin 
    state <= standby;
    BALANCE <= 64'b0;
    INTENTOS <= 2'b0;
    INPUT_PIN <= 16'b0;
    TEMP_MONTO <= 31'b0;
    PIN_CORRECTO <= 1'b0;

  end else begin
    state <= nextState;          // Transición a estado futuro
    BALANCE <= nextBALANCE;      // Transición para gestion del balance
    INTENTOS <= nextINTENTOS;    // Transición para aumento de contador
    INPUT_PIN <= nextINPUT_PIN;      // Transición para gestion del input pin
    PIN_CORRECTO <= nextPIN_CORRECTO;
  end
end

always @(*) begin                // Lógica combinacional
  
  nextState = state;             // Sosteniendo estado actual
  nextINTENTOS = INTENTOS;       // Sosteniendo contador actual
  nextBALANCE = BALANCE;         // Sosteniendo el valor del balance
  nextINPUT_PIN = INPUT_PIN;
  nextPIN_CORRECTO = PIN_CORRECTO;
  

  ENTREGAR_DINERO = 1'b0;
  FONDOS_INSUFICIENTES = 1'b0;
  BALANCE_ACTUALIZADO = 1'b0;
  BLOQUEO = 1'b0;
  PIN_INCORRECTO = 1'b0;
  ADVERTENCIA = 1'b0;
  
  /* Casos para cada estado*/

  case(state)

    standby: begin


               
               if (TARJETA_RECIBIDA) begin      // Ingreso de tarjeta
                  nextState = validacion;       // pasa a validación
                  nextBALANCE = FONDOS;         // obtención del dato FONDOS
               end
             end
    validacion: begin
                  /* Para el caso de pin correcto, se envia a la transacción
                  deseada */
                  if (PIN_CORRECTO && ~TIPO_TRANS) begin 
                     nextState = deposito;
                  end else if (PIN_CORRECTO && TIPO_TRANS) begin
                     nextState = retiro;
                 /*En caso de presionar el botón para borrar pin
                   INPUT_PIN vuelve a cero*/
                  end else if (ERASE_PIN) begin
                     nextINPUT_PIN = INPUT_PIN << 16;
                  /*Para al terminar de ingresar el pin se presiona ENTER
                    y se compara con el PIN de la tarjeta*/
                  end else if (ENTER_PIN) begin
                     /*Se envia la alerta a cero para considerar el caso en
                       el que el pin es correcto y esta deje de estar activa*/
                        PIN_INCORRECTO = 0;  
                        
                     if (INPUT_PIN == PIN) begin
                        nextPIN_CORRECTO = 1;
                        ADVERTENCIA = 0;
                     end else /*if (!(INPUT_PIN == PIN))*/ begin
                        PIN_INCORRECTO = 1;
                        // Pin incorrecto, aumento de intentos usados
                        nextINTENTOS = INTENTOS+1;
                     end

                  // Al haber dos intentos, se envia advertencia
                  end else if (INTENTOS == 2) begin
                        ADVERTENCIA = 1;
                  // En 3 intentos se pasa al estado de bloqueo
                  end else if (INTENTOS == 3) begin
                     nextState = bloqueo;
                  
                  // Se usa un shifteo de 4, para agrupar los digitos
                  // del pin en INPUT_PIN
                  end else if (DIGITO_STB) begin
                    nextINPUT_PIN = (INPUT_PIN << 4) | DIGITO;
                  end else begin
                     nextState = validacion;
                  end
                end
    deposito: begin
                if (MONTO_STB) begin
                   TEMP_MONTO = MONTO;
                end else if (ENTER_PIN) begin
                   nextBALANCE = BALANCE + TEMP_MONTO;
                   BALANCE_ACTUALIZADO = 1;
                end

              end
    retiro: begin
               if (MONTO_STB) begin
                  TEMP_MONTO = MONTO;
               end else if (ENTER_PIN) begin
                  if (BALANCE >= TEMP_MONTO) begin
                     nextBALANCE = BALANCE - TEMP_MONTO;
                     BALANCE_ACTUALIZADO = 1;
                     ENTREGAR_DINERO = 1;
                     nextState = standby;
                  end else if (BALANCE < TEMP_MONTO)  begin
                     FONDOS_INSUFICIENTES = 1;
                     nextState = standby; 
                  end
               end
            end
    
    bloqueo:   begin
                  BLOQUEO = 1;
               end
    
    default: nextState = standby;

  endcase

end


endmodule 
