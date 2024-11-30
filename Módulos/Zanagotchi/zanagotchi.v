module zanagotchi
(
    input wire b1, b2, clk,
    output wire io_sclk,
    output wire io_sdin,
    output wire io_cs,
    output wire io_dc,
    output wire io_reset
);
    wire[3:0] estado;
    wire[7:0] fome, felicidade, sono;
    wire morreu, b1_aux, b2_aux;
    wire[7:0] data_to_send;
    wire[9:0] byte_counter;

    // Instancia o módulo de controle dos botões
    controlador_botao B1
    (
        .clk(clk),
        .b_in(b1),
        .b_out(b1_aux)
    );

    controlador_botao B2
    (
        .clk(clk),
        .b_in(b2),
        .b_out(b2_aux)
    );

    // Instancia o módulo de controle de estados
    controlador_estados EST
    ( 
        .clk(clk), 
        .b1(b1_aux), 
        .b2(b2_aux),
        .fome(fome), 
        .felicidade(felicidade), 
        .sono(sono),
        .estado(estado)
    );

    // Instancia o módulo de controle de atributos
    controlador_atributos ATR
    ( 
        .clk(clk), 
        .estado(estado),
        .fome(fome), 
        .felicidade(felicidade), 
        .sono(sono)
    ); 

    // Instancia o módulo de controle das imagens para o display
    controlador_imagens IMG
    (
        .clk(clk),
        .estado(estado),
        .fome(fome),
        .felicidade(felicidade),
        .sono(sono),
        .byte_counter(byte_counter),
        .data_to_send(data_to_send)
    );
    
    // Instancia o módulo que joga a imagem recebida para o display
    controlador_display DIS
    (
        .clk(clk),
        .data_to_send(data_to_send),
        .byte_counter(byte_counter),
        .io_sclk(io_sclk),
        .io_sdin(io_sdin),
        .io_cs(io_cs),
        .io_dc(io_dc),
        .io_reset(io_reset)
    );

endmodule