module zanagotchi
(
    input wire b1, b2, clk
);

    wire[2:0] estado;
    wire[7:0] fome, felicidade, sono;
    wire morreu;

    // Instancia o módulo de controle de estados
    controlador_estados EST
    ( 
        .clk(clk), 
        .b1(b1), 
        .b2(b2),
        .morreu(morreu),
        .estado(estado)
    );

    // Instancia o módulo de controle de atributos
    controlador_atributos ATR
    ( 
        .clk(clk), 
        .estado(estado), 
        .fome(fome), 
        .felicidade(felicidade), 
        .sono(sono),
        .morreu(morreu)
    ); 

endmodule