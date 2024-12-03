`timescale 1ms / 1ps

module zanagotchi_tb ();

reg b1, b2, clk;
wire [3:0] estado;
wire [7:0] fome, felicidade, sono;
wire morreu;
wire[1024*8-1:0] imagem;
wire io_sclk;
wire io_sdin;
wire io_cs;
wire io_dc;
wire io_reset;

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
integer file;

initial 
begin

    // Inicializa os sinais
    $display("\n\nInicializando Zanagotchi...");
    b1 = 0;
    b2 = 0;
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);
    
    file = $fopen("../Imagens/LogImagens/zanagotchi_idle1.hex", "w");

    // Imagem do estado
    for (integer i = 0; i < 1023; i = i + 1)
        $fwrite(file, "%02x ", DUT.IMG.imagem[i*8 +: 8]);
    $fwrite(file, "%02x", DUT.IMG.imagem[1023*8 +: 8]);  // Último byte sem espaço
    
    $fclose(file);
    $display("Imagem escrita em /Imagens/LogImagens/zanagotchi_idle1.hex\n");
    
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
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Solta botões
    b1 = 0;
    b2 = 0;
    #10;

    file = $fopen("../Imagens/LogImagens/zanagotchi_comendo1.hex", "w");

    // Imagem do estado
    for (integer i = 0; i < 1023; i = i + 1)
        $fwrite(file, "%02x ", DUT.IMG.imagem[i*8 +: 8]);
    $fwrite(file, "%02x", DUT.IMG.imagem[1023*8 +: 8]);  // Último byte sem espaço
    
    $fclose(file);
    $display("Imagem escrita em /Imagens/LogImagens/zanagotchi_comendo1.hex\n");

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

    // Solta botões
    b1 = 0;
    b2 = 0;
    #10;

    file = $fopen("../Imagens/LogImagens/zanagotchi_dormindo1.hex", "w");

    // Imagem do estado
    for (integer i = 0; i < 1023; i = i + 1)
        $fwrite(file, "%02x ", DUT.IMG.imagem[i*8 +: 8]);
    $fwrite(file, "%02x", DUT.IMG.imagem[1023*8 +: 8]);  // Último byte sem espaço
    
    $fclose(file);
    $display("Imagem escrita em /Imagens/LogImagens/zanagotchi_dormindo1.hex\n");

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
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d \nMORREU: %b", DUT.EST.estado, DUT.ATR.fome, DUT.ATR.sono, DUT.ATR.felicidade, DUT.ATR.morreu);

    // Solta botões
    b1 = 0;
    b2 = 0;
    #10;

    file = $fopen("../Imagens/LogImagens/zanagotchi_dando_aula1.hex", "w");

    // Imagem do estado
    for (integer i = 0; i < 1023; i = i + 1)
        $fwrite(file, "%02x ", DUT.IMG.imagem[i*8 +: 8]);
    $fwrite(file, "%02x", DUT.IMG.imagem[1023*8 +: 8]);  // Último byte sem espaço
    
    $fclose(file);
    $display("Imagem escrita em /Imagens/LogImagens/zanagotchi_dando_aula1.hex\n");

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

    file = $fopen("../Imagens/LogImagens/zanagotchi_morto1.hex", "w");

    // Imagem do estado
    for (integer i = 0; i < 1023; i = i + 1)
        $fwrite(file, "%02x ", DUT.IMG.imagem[i*8 +: 8]);
    $fwrite(file, "%02x", DUT.IMG.imagem[1023*8 +: 8]);  // Último byte sem espaço
    
    $fclose(file);
    $display("Imagem escrita em /Imagens/LogImagens/zanagotchi_morto1.hex\n");

    $finish;
end

endmodule
