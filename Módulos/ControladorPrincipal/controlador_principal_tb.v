`timescale 1ms / 1ps

module tb_controlador_principal ();

reg b1, b2, clk;
wire [2:0] estado;
wire [7:0] fome, felicidade, sono;

controlador_principal DUT (
    .b1(b1), 
    .b2(b2), 
    .clk(clk), 
    .estado(estado), 
    .fome(fome), 
    .felicidade(felicidade), 
    .sono(sono)
);

initial
begin
    clk = 0;
end

always 
begin 
    #5 clk = ~clk;
end

integer morreu, i;

initial 
    begin

    // Inicializa botões
    $display("-------------------------");
    $display("INICIALIZA");
    b1 = 0;
    b2 = 0;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);
    $display("-------------------------\n");

    #3000;  // 3 segundos se passam
    $display("3 segundos depois...");
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d\n---\n", estado, fome, sono, felicidade);

    // IDLE para COMENDO
    $display("-------------------------");
    $display("IDLE para COMENDO"); 
    b1 = 1;
    b2 = 0;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);
    $display("-------------------------\n");

    b1 = 0;
    b2 = 0;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado comendo e verificando a fome subir");
    for (integer i = 0; i < 3; i++)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);

    end
    $display("-------------------------\n");

    // COMENDO para IDLE
    $display("-------------------------");
    $display("COMENDO para IDLE"); 
    b1 = 1;
    b2 = 0;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);
    $display("-------------------------\n");

    // IDLE para DORMINDO
    $display("-------------------------");
    $display("IDLE para DORMINDO"); 
    b1 = 0;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);
    $display("-------------------------\n");

    b1 = 0;
    b2 = 0;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado dormindo e verificando o sono subir");
    for (integer i = 0; i < 3; i++)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);

    end
    $display("-------------------------\n");

    // DORMINDO para IDLE
    $display("-------------------------");
    $display("DORMINDO para IDLE"); 
    b1 = 0;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);
    $display("-------------------------\n");

    // IDLE para DANDO_AULA
    $display("-------------------------");
    $display("IDLE para DANDO_AULA"); 
    b1 = 1;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);
    $display("-------------------------\n");

    b1 = 0;
    b2 = 0;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado dormindo e verificando a felicidade subir");
    for (integer i = 0; i < 3; i++)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);

    end
    $display("-------------------------\n");

    // DANDO_AULA para IDLE
    $display("-------------------------");
    $display("DANDO_AULA para IDLE"); 
    b1 = 1;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);
    $display("-------------------------\n");

    // TESTA MORTE
    $display("-------------------------");
    $display("FAZ NADA ATÉ MORRER");
    b1 = 0;
    b2 = 0;
    #10;
    morreu = 0;
    i = 0;

    while (morreu == 0)
    begin

        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d", estado, fome, sono, felicidade);

        if (estado == 3'b100)
            morreu = 1;
        i = i + 1;
    end
    $display("-------------------------\n");

    $finish;
end

endmodule
