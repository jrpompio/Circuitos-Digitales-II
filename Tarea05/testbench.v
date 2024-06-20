`include "tester.v"
`include "I2cMaster.v"
module testbench;
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire                    CLK;                    // From TESTER of tester.v
wire [6:0]              I2C_ADDR;               // From TESTER of tester.v
wire [15:0]             RD_DATA;                // From UUT of I2cMaster.v
wire                    RESET;                  // From TESTER of tester.v
wire                    RNW;                    // From TESTER of tester.v
wire                    SCL;                    // From UUT of I2cMaster.v
wire                    SDA_IN;                 // From TESTER of tester.v
wire                    SDA_OE;                 // From UUT of I2cMaster.v
wire                    SDA_OUT;                // From UUT of I2cMaster.v
wire                    START_STB;              // From TESTER of tester.v
wire                    TWOBYTE;                // From TESTER of tester.v
wire [15:0]             WR_DATA;                // From TESTER of tester.v
// End of automatics

initial begin
    $dumpfile("ondas.vcd");
    $dumpvars;
end

I2cMaster UUT(/*AUTOINST*/
              // Outputs
              .SDA_OUT                  (SDA_OUT),
              .SDA_OE                   (SDA_OE),
              .RD_DATA                  (RD_DATA[15:0]),
              .SCL                      (SCL),
              // Inputs
              .CLK                      (CLK),
              .RESET                    (RESET),
              .RNW                      (RNW),
              .START_STB                (START_STB),
              .SDA_IN                   (SDA_IN),
              .TWOBYTE                  (TWOBYTE),
              .I2C_ADDR                 (I2C_ADDR[6:0]),
              .WR_DATA                  (WR_DATA[15:0]));

tester TESTER(/*AUTOINST*/
              // Outputs
              .CLK                      (CLK),
              .RESET                    (RESET),
              .RNW                      (RNW),
              .START_STB                (START_STB),
              .SDA_IN                   (SDA_IN),
              .TWOBYTE                  (TWOBYTE),
              .I2C_ADDR                 (I2C_ADDR[6:0]),
              .WR_DATA                  (WR_DATA[15:0]),
              // Inputs
              .SDA_OUT                  (SDA_OUT),
              .SDA_OE                   (SDA_OE),
              .SCL                      (SCL),
              .RD_DATA                  (RD_DATA[15:0]));

endmodule

// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
