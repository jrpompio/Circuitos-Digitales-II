`include "quiz4.v"
`include "tester.v"

module testbench;
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire                    ARRANQUE;               // From TESTER of tester.v
wire                    CLK;                    // From TESTER of tester.v
wire                    MODO;                   // From TESTER of tester.v
wire                    MOTOR1;                 // From UUT of quiz4.v
wire                    MOTOR2;                 // From UUT of quiz4.v
wire                    REINICIO;               // From TESTER of tester.v
// End of automatics

initial begin
    $dumpfile("ondas.vcd");
    $dumpvars;
end

quiz4 UUT(/*AUTOINST*/
          // Outputs
          .MOTOR1                       (MOTOR1),
          .MOTOR2                       (MOTOR2),
          // Inputs
          .CLK                          (CLK),
          .REINICIO                     (REINICIO),
          .ARRANQUE                     (ARRANQUE),
          .MODO                         (MODO));

tester TESTER(/*AUTOINST*/
              // Outputs
              .CLK                      (CLK),
              .REINICIO                 (REINICIO),
              .ARRANQUE                 (ARRANQUE),
              .MODO                     (MODO),
              // Inputs
              .MOTOR1                   (MOTOR1),
              .MOTOR2                   (MOTOR2));

endmodule

// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
