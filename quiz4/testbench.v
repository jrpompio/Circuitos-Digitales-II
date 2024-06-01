`include "quiz4.v"
`include "tester.v"

module testbench;
/*AUTOWIRE*/

initial begin
    $dumpfile("ondas.vcd");
    $dumpvars;
end

quiz4 UUT(/*AUTOINST*/);

tester TESTER(/*AUTOINST*/);

endmodule

// Local Variables:
// verilog-auto-library-flags:("-y .")
// End:
