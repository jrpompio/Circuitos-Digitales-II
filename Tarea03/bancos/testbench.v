`include "ATM.v"

module testbench;

/*AUTOWIRE*/
wire BALANCE_ACTUALIZADO, ENTREGAR_DINERO, FONDOS_INSUFICIENTES,
TARJETA_RECIBIDA, TIPO_TRANS, PIN_INCORRECTO, ADVERTENCIA, BLOQUEO,
clk, reset, DIGITO_STB, MONTO_STB, ENTER_PIN, ERASE_PIN;
wire [15:0] PIN;
wire [3:0] DIGITO;
wire [31:0] MONTO;
wire [63:0] FONDOS;

initial begin
    $dumpfile("ondas.vcd");
    $dumpvars;
end

ATM UUT(/*AUTOINST*/
        // Outputs
        .BALANCE_ACTUALIZADO            (BALANCE_ACTUALIZADO),
        .ENTREGAR_DINERO                (ENTREGAR_DINERO),
        .FONDOS_INSUFICIENTES           (FONDOS_INSUFICIENTES),
        .PIN_INCORRECTO                 (PIN_INCORRECTO),
        .ADVERTENCIA                    (ADVERTENCIA),
        .BLOQUEO                        (BLOQUEO),
        // Inputs
        .clk                            (clk),
        .reset                          (reset),
        .TARJETA_RECIBIDA               (TARJETA_RECIBIDA),
        .PIN                            (PIN[15:0]),
        .ERASE_PIN                      (ERASE_PIN),
        .FONDOS                         (FONDOS[63:0]),
        .DIGITO                         (DIGITO[3:0]),
        .DIGITO_STB                     (DIGITO_STB),
        .ENTER_PIN                      (ENTER_PIN),
        .TIPO_TRANS                     (TIPO_TRANS),
        .MONTO                          (MONTO[31:0]),
        .MONTO_STB                      (MONTO_STB));


tester TESTER(/*AUTOINST*/
              // Outputs
              .clk                      (clk),
              .reset                    (reset),
              .TARJETA_RECIBIDA         (TARJETA_RECIBIDA),
              .DIGITO_STB               (DIGITO_STB),
              .TIPO_TRANS               (TIPO_TRANS),
              .MONTO_STB                (MONTO_STB),
              .ENTER_PIN                (ENTER_PIN),
              .ERASE_PIN                (ERASE_PIN),
              .PIN                      (PIN[15:0]),
              .DIGITO                   (DIGITO[3:0]),
              .MONTO                    (MONTO[31:0]),
              .FONDOS                   (FONDOS[63:0]),
              // Inputs
              .BALANCE_ACTUALIZADO      (BALANCE_ACTUALIZADO),
              .ENTREGAR_DINERO          (ENTREGAR_DINERO),
              .FONDOS_INSUFICIENTES     (FONDOS_INSUFICIENTES),
              .PIN_INCORRECTO           (PIN_INCORRECTO),
              .ADVERTENCIA              (ADVERTENCIA),
              .BLOQUEO                  (BLOQUEO));

endmodule

// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
