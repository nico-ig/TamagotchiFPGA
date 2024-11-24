`timescale 1ns/1ns

module test();
    reg clk = 0, b_in = 0;
    wire b_out;

    controlador_botao DUT (
        .clk(clk),
        .b_in(b_in),
        .b_out(b_out)
    );

    initial
    begin
        $dumpfile("controlador_botao.vcd");
        $dumpvars(0,test);
    end

    initial
    begin
            
        $monitor("SAIDA: %b", b_out);
        $display("-------------------------");
        
        $display("BOTAO SOLTO");
        b_in = 0;
        clk = #1 0;
        clk = #1 1;

        $display("BOTAO PRESSIONADO");
        b_in = 1;
        clk = #1 0;
        clk = #1 1;

        $display("Aguarda...");
        for (integer i = 0; i < 1024; i++)
        begin
            clk = #1 ~clk;
        end
        
        $display("BOTAO PRESSIONADO");
        b_in = 1;
        clk = #1 0;
        clk = #1 1;

        $display("BOTAO SOLTO");
        b_in = 0;
        clk = #1 0;
        clk = #1 1;

        $display("Aguarda...");
        for (integer i = 0; i < 1024; i++)
        begin
            clk = #1 ~clk;
        end

        $display("BOTAO PRESSIONADO");
        b_in = 1;
        clk = #1 0;
        clk = #1 1;

        $display("BOTAO SOLTO");
        b_in = 0;
        clk = #1 0;
        clk = #1 1;

        $display("BOTAO PRESSIONADO");
        b_in = 1;
        clk = #1 0;
        clk = #1 1;

        $display("BOTAO SOLTO");
        b_in = 0;
        clk = #1 0;
        clk = #1 1;

        $display("Aguarda...");
        for (integer i = 0; i < 20; i++)
        begin
            clk = #1 ~clk;
        end

        $display("BOTAO PRESSIONADO");
        b_in = 1;
        clk = #1 0;
        clk = #1 1;

        $display("-------------------------\n");

        $finish();
    end
endmodule;