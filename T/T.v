module T (
    input wire t,
    input wire clk,
    output reg q
);
    //Se inicializan los valores de los regs
    initial begin
        q=0;
    end

    //Se realizarán cambios unicament en flancos positivos del reloj
    always @(posedge clk) begin
        if (t) begin
            q  <= ~q;
        end
    end
endmodule