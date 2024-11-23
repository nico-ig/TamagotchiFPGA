`timescale 1ms / 1ps

module controlador_estados_tb ();

reg b1, b2, morreu, clk;
wire [3:0] estado;

controlador_estados DUT (
    .b1(b1), 
    .b2(b2), 
    .morreu(morreu),
    .clk(clk), 
    .estado(estado)
);

initial
begin
    clk = 0;
end

always 
begin 
    #5 clk = ~clk;
end

integer i;

initial 
    begin

    // Inicializa botões
    $display("-------------------------");
    $display("INICIALIZA");
    b1 = 0;
    b2 = 0;
    #10;
    $display("ESTADO: %b", estado);
    $display("-------------------------\n");

    #3000;  // 3 segundos se passam
    $display("3 segundos depois...");
    $display("ESTADO: %b", estado);

    // IDLE para COMENDO
    $display("-------------------------");
    $display("IDLE para COMENDO"); 
    b1 = 1;
    b2 = 0;
    #10;
    $display("ESTADO: %b", estado);
    $display("-------------------------\n");

    b1 = 0;
    b2 = 0;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado comendo");
    for (integer i = 0; i < 3; i++)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b", estado);

    end
    $display("-------------------------\n");

    // COMENDO para IDLE
    $display("-------------------------");
    $display("COMENDO para IDLE"); 
    b1 = 1;
    b2 = 0;
    #10;
    $display("ESTADO: %b", estado);
    $display("-------------------------\n");

    // IDLE para DORMINDO
    $display("-------------------------");
    $display("IDLE para DORMINDO"); 
    b1 = 0;
    b2 = 1;
    #10;
    $display("ESTADO: %b", estado);
    $display("-------------------------\n");

    b1 = 0;
    b2 = 0;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado dormindo");
    for (integer i = 0; i < 3; i++)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b", estado);

    end
    $display("-------------------------\n");

    // DORMINDO para IDLE
    $display("-------------------------");
    $display("DORMINDO para IDLE"); 
    b1 = 0;
    b2 = 1;
    #10;
    $display("ESTADO: %b", estado);
    $display("-------------------------\n");

    // IDLE para DANDO_AULA
    $display("-------------------------");
    $display("IDLE para DANDO_AULA"); 
    b1 = 1;
    b2 = 1;
    #10;
    $display("ESTADO: %b", estado);
    $display("-------------------------\n");

    b1 = 0;
    b2 = 0;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado dormindo");
    for (integer i = 0; i < 3; i++)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b", estado);

    end
    $display("-------------------------\n");

    // DANDO_AULA para IDLE
    $display("-------------------------");
    $display("DANDO_AULA para IDLE"); 
    b1 = 1;
    b2 = 1;
    #10;
    $display("ESTADO: %b", estado);
    $display("-------------------------\n");

    // TESTA MORTE
    $display("-------------------------");
    $display("Morreu");
    #10;
    morreu = 1;
    i = 0;

    for (integer i = 0; i < 3; i++)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b", estado);

    end

    $finish;
end

endmodule
