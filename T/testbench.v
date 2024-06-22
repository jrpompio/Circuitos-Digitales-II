`include "tester.v"
`include "T.v"

module testbench;
/*AUTOWIRE*/
wire VCC, CLK, QA, QB, QC, SA, SB, SC, E, F, G;

wire [3:0] MOD;

initial begin
    $dumpfile("ondas.vcd");
    $dumpvars;
end
//1101
assign SA = QA & ~(QD&QC&(~QB)) ;
assign SB = QB & SA | (QD&QC&(~QB)&QA); 
assign SC = QC & SB;


assign MOD[0] = QA;
assign MOD[1] = QB;
assign MOD[2] = QC;
assign MOD[3] = QD;

tester TESTER(
        .CLK (CLK),
        .VCC (VCC)
);

T UA(
    .t (1),
    .clk (CLK),
    .q (QA)
);

T UB(
    .t (SA),
    .clk (CLK),
    .q (QB)
);

T UC(
    .t (SB),
    .clk (CLK),
    .q (QC)
);

T UD(
    .t (SC),
    .clk (CLK),
    .q (QD)
);


endmodule

