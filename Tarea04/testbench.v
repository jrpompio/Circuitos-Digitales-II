`include "tester.v"
`include "spiMaster.v"

module testbench;
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire                    CKP;                    // From TESTER of tester.v
wire                    CLK;                    // From TESTER of tester.v
wire                    CPH;                    // From TESTER of tester.v
wire                    CS;                     // From UUT of spiMaster.v
wire [7:0]              DATAINPUT;              // From TESTER of tester.v
wire                    ENABLE;                 // From TESTER of tester.v
wire                    MISO;                   // From TESTER of tester.v
wire                    MOSI;                   // From UUT of spiMaster.v
wire                    RESET;                  // From TESTER of tester.v
wire                    SCK;                    // From UUT of spiMaster.v
// End of automatics

initial begin
    $dumpfile("ondas.vcd");
    $dumpvars;
end

spiMaster UUT(/*AUTOINST*/
              // Outputs
              .MOSI                     (MOSI),
              .SCK                      (SCK),
              .CS                       (CS),
              // Inputs
              .CLK                      (CLK),
              .RESET                    (RESET),
              .CKP                      (CKP),
              .CPH                      (CPH),
              .MISO                     (MISO),
              .ENABLE                   (ENABLE),
              .DATAINPUT                (DATAINPUT[7:0]));

tester TESTER(/*AUTOINST*/
              // Outputs
              .CLK                      (CLK),
              .RESET                    (RESET),
              .CKP                      (CKP),
              .CPH                      (CPH),
              .MISO                     (MISO),
              .ENABLE                   (ENABLE),
              .DATAINPUT                (DATAINPUT[7:0]),
              // Inputs
              .MOSI                     (MOSI),
              .SCK                      (SCK),
              .CS                       (CS));

endmodule

// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
