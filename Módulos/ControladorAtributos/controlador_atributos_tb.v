`timescale 1ms / 1ps

module controlador_atributos_tb ();

reg clk;
reg [3:0] estado;
wire [7:0] fome, felicidade, sono;
wire morreu;

// Instancia o módulo controlador_atributos
controlador_atributos DUT (
    .clk(clk),
    .estado(estado),
    .fome(fome),
    .felicidade(felicidade),
    .sono(sono),
    .morreu(morreu)
);

initial 
begin
    clk = 0;
end

always 
begin 
    #5 clk = ~clk;
end

initial 
begin
    $display("-------------------------");
    $display("INICIALIZA");
    estado = 4'b0000; // IDLE
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    $display("-------------------------\n");

    #3000;  // 3 segundos se passam
    $display("3 segundos depois...");
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);

    // Testando o estado DORMINDO
    $display("-------------------------");
    $display("Estado: DORMINDO");
    estado = 4'b0001; 
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    $display("-------------------------\n");

    estado = 4'b0001;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado DORMINDO e verificando o sono subir");
    for (integer i = 0; i < 3; i++)
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    end
    $display("-------------------------\n");

    // Testando o estado COMENDO
    $display("-------------------------");
    $display("Estado: COMENDO");
    estado = 4'b0010; 
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    $display("-------------------------\n");

    estado = 4'b0010;
    #10;
    $display("-------------------------");
    $display("Mantendo no estado COMENDO e verificando a fome subir");
    for (integer i = 0; i < 3; i++)
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    end
    $display("-------------------------\n");

    // Testando o estado DANDO_AULA
    $display("-------------------------");
    $display("Estado: DANDO_AULA");
    estado = 4'b0100; 
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    $display("-------------------------\n");

    #10;
    $display("-------------------------");
    $display("Mantendo no estado DANDO_AULA e verificando a felicidade subir");
    for (integer i = 0; i < 3; i++)
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    end
    $display("-------------------------\n");

    // Retornar a IDLE para testar decremento de atributos
    $display("-------------------------");
    $display("Estado: IDLE");
    estado = 4'b0000; 
    #10;
    $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    $display("-------------------------\n");

    while (!morreu)
    begin
        #3000;  // 3 segundos se passam
        $display("3 segundos depois em IDLE...");
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: ", estado, fome, sono, felicidade, morreu);
    end

    $display("Mantendo no estado MORREU e vendo os atributos diminuirem");
    while(fome || sono || felicidade)
    begin
        #1000;
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    end
    $display("-------------------------\n");

    $display("Mantendo no estado MORREU e vendo os atributos nao mudarem");
    for (integer i = 0; i < 3; i++)
    begin
        #1000;
        $display("%d segundo(s) depois...", i + 1);
        $display("ESTADO: %b \nFO|SO|FE: %d|%d|%d MORREU: %d", estado, fome, sono, felicidade, morreu);
    end
    $display("-------------------------\n");
    $finish;
end

endmodule
