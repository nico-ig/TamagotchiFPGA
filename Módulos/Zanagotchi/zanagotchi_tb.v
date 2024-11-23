`timescale 1ms / 1ps

module zanagotchi_tb ();

reg b1, b2, clk;
wire [2:0] estado;
wire [7:0] fome, felicidade, sono;
wire morreu;

zanagotchi DUT 
(
    .b1(b1), 
    .b2(b2), 
    .clk(clk)
);

// Relógio inicializado
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
    // Inicializa os sinais
    $display("Inicializando o sistema...");
    b1 = 0;
    b2 = 0;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Espera 3 segundos
    #3000;
    $display("3 segundos depois...");
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Testa transição de estados e mudanças de atributos

    // IDLE para COMENDO
    $display("IDLE para COMENDO");
    b1 = 1;
    b2 = 0;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Mantendo no estado COMENDO e verificando a fome subir
    $display("Mantendo no estado COMENDO e verificando a fome subir");
    for (i = 0; i < 3; i = i + 1) 
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);
    end

    // COMENDO para IDLE
    $display("\nCOMENDO para IDLE");
    b1 = 1;
    b2 = 0;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // IDLE para DORMINDO
    $display("IDLE para DORMINDO");
    b1 = 0;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Mantendo no estado DORMINDO e verificando o sono subir
    $display("Mantendo no estado DORMINDO e verificando o sono subir");
    for (i = 0; i < 3; i = i + 1)
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);
    end

    // DORMINDO para IDLE
    $display("\nDORMINDO para IDLE");
    b1 = 0;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // IDLE para DANDO_AULA
    $display("IDLE para DANDO_AULA");
    b1 = 1;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Mantendo no estado DANDO_AULA e verificando a felicidade subir
    $display("Mantendo no estado DANDO_AULA e verificando a felicidade subir");
    for (i = 0; i < 6; i = i + 1) 
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);
    end

    // DANDO_AULA para IDLE
    $display("\nDANDO_AULA para IDLE");
    b1 = 1;
    b2 = 1;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Testa morte do personagem
    $display("FAZ NADA ATÉ MORRER");
    b1 = 0;
    b2 = 0;
    i = 0;
    while (DUT.ATR.morreu == 0) 
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b\n", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);
        i = i + 1;
    end

    $display("Morreu depois de %d segundos", i);
    $finish;
end

endmodule
