`timescale 1 ms / 1 ms  // time-unit = 100ms , precision = 10 ms

`include "tester.v"
`include "I2cMain.v"
`include "I2cSecondary.v"2

module testbench;
/*AUTOWIRE*/
// Beginning of automatic wires (for undeclared instantiated-module outputs)
wire                    CLK;                    // From TESTER of tester.v
wire [6:0]              I2CS_ADDR;              // From TESTER of tester.v
wire [6:0]              I2C_ADDR;               // From TESTER of tester.v
wire [15:0]             RDS_DATA;               // From TESTER of tester.v
wire [15:0]             RD_DATA;                // From UUT of I2cMain.v
wire                    RESET;                  // From TESTER of tester.v
wire                    RNW;                    // From TESTER of tester.v
wire                    SCL;                    // From UUT of I2cMain.v
wire                    SDA_IN;                 // From TESTER of tester.v, ...
wire                    SDA_OE;                 // From UUT of I2cMain.v
wire                    SDA_OUT;                // From UUT of I2cMain.v
wire                    START_STB;              // From TESTER of tester.v
wire [15:0]             WRS_DATA;               // From UUT2 of I2cSecondary.v
wire [15:0]             WR_DATA;                // From TESTER of tester.v
// End of automatics

initial begin
    $dumpfile("ondas.vcd");
   $dumpvars(-1, UUT);
   $dumpvars(-1, UUT2);
   $dumpvars(-1, UUT3);
    $dumpvars;
end

I2cMain UUT(/*AUTOINST*/
            // Outputs
            .SDA_OUT                    (SDA_OUT),
            .SDA_OE                     (SDA_OE),
            .RD_DATA                    (RD_DATA[15:0]),
            .SCL                        (SCL),
            // Inputs
            .CLK                        (CLK),
            .RESET                      (RESET),
            .RNW                        (RNW),
            .START_STB                  (START_STB),
            .SDA_IN                     (SDA_IN),
            .I2C_ADDR                   (I2C_ADDR[6:0]),
            .WR_DATA                    (WR_DATA[15:0]));

I2cSecondary UUT2 (/*AUTOINST*/
                   // Outputs
                   .SDA_IN              (SDA_IN),
                   .WRS_DATA            (WRS_DATA[15:0]),
                   // Inputs
                   .CLK                 (CLK),
                   .RESET               (RESET),
                   .SDA_OUT             (SDA_OUT),
                   .SDA_OE              (SDA_OE),
                   .SCL                 (SCL),
                   .RDS_DATA            (RDS_DATA[15:0]),
                   .I2CS_ADDR           (I2CS_ADDR[6:0]));

I2cSecondary UUT3 (/*AUTOINST*/
                   // Outputs
                   .SDA_IN              (SDA_IN),
                   .WRS_DATA            (WRS_DATA[15:0]),
                   // Inputs
                   .CLK                 (CLK),
                   .RESET               (RESET),
                   .SDA_OUT             (SDA_OUT),
                   .SDA_OE              (SDA_OE),
                   .SCL                 (SCL),
                   .RDS_DATA            (RDS_DATA[15:0]),
                   .I2CS_ADDR           (I2CS_ADDR[6:0]));

tester TESTER(/*AUTOINST*/
              // Outputs
              .CLK                      (CLK),
              .RESET                    (RESET),
              .RNW                      (RNW),
              .START_STB                (START_STB),
              .SDA_OUT                  (SDA_OUT),
              .SCL                      (SCL),
              .I2C_ADDR                 (I2C_ADDR[6:0]),
              .I2CS_ADDR                (I2CS_ADDR[6:0]),
              .WR_DATA                  (WR_DATA[15:0]),
              .RDS_DATA                 (RDS_DATA[15:0]),
              // Inputs
              .RD_DATA                  (RD_DATA[15:0]),
              .WRS_DATA                 (WRS_DATA[15:0]));


endmodule



// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
