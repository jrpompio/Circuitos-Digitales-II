/**************************************************************************//**
 * @file AutomatedTellerMachine.v
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
   // Inputs
   clk, reset, TARJETA_RECIBIDA, PIN, DIGITO, DIGITO_STB, TIPO_TRANS,
   MONTO_STB, MONTO
   );

/*AUTOINPUT*/
input clk;                 /**< Señal de reloj para sinconizar el modulo */
input reset;               /**< Señal de reinicio, reinicia en flanco bajo */
input TARJETA_RECIBIDA;    /**< Señal de entraba binaria que indica si se ha
                                introducido una tarjeta valida*/
input [15:0] PIN;          /**< Entrada de 16 bits donde cada grupo de 4 bits 
                                representa un digito del PIN de la tarjeta que
                                se recibió*/
input DIGITO;              /**< Entrada de 4 bits que representa el último 
                                dígito tecleado por el usuario, mantiene 
                                su valor anterior hasta que se preciona
                                la tecla siguiente*/
input DIGITO_STB;          /**< */
input TIPO_TRANS;          /**< asfasdgasdf*/
input MONTO_STB;           /**< asdfasdf*/
input MONTO;               /**< asdfasdf*/

endmodule
