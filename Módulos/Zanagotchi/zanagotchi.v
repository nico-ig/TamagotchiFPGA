module zanagotchi
(
    input wire b1, b2, clk
);

    wire[3:0] estado;
    wire[7:0] fome, felicidade, sono;
    wire morreu;
    wire[1024*8-1:0] imagem;
    wire io_sclk;
    wire io_sdin;
    wire io_cs;
    wire io_dc;
    wire io_reset;
    wire b1_aux, b2_aux;

    controlador_botao B1
    (
        .b_in(b1),
        .clk(clk),
        .b_out(b1_aux)
    );

    controlador_botao B2
    (
        .b_in(b2),
        .clk(clk),
        .b_out(b2_aux)
    );

    // Instancia o módulo de controle de estados
    controlador_estados EST
    ( 
        .clk(clk), 
        .b1(b1_aux), 
        .b2(b2_aux),
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

    // Instancia o módulo de controle das imagens para o display
    controlador_imagens IMG
    (
        .clk(clk),
        .estado(estado),
        .imagem(imagem)
    );
    
    // Instancia o módulo que joga a imagem recebida para o display
    controlador_display DIS
    (
        .clk(clk),
        .image(imagem),
        .io_sclk(io_sclk),
        .io_sdin(io_sdin),
        .io_cs(io_cs),
        .io_dc(io_dc),
        .io_reset(io_reset)
    );

endmodule