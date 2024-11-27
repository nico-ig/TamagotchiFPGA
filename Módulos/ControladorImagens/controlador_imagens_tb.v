`timescale 1ms / 1ps

module controlador_imagens_tb();

    reg clk;
    reg [3:0] estado;
    wire [1024*8-1:0] imagem;

    controlador_imagens DUT 
    (
        .clk(clk),
        .estado(estado),
        .imagem(imagem)
    );

    // Inteiro para o arquivo
    integer file;

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
        // IDLE
        estado = 4'b0000;
        #10;
        file = $fopen("../Imagens/LogImagens/zanagotchi_idle1.hex", "w");

        for (integer i = 0; i < 1023; i = i + 1)
            $fwrite(file, "%02x ", imagem[i*8 +: 8]);
        $fwrite(file, "%02x", imagem[1023*8 +: 8]);  // Último byte sem espaço
        
        $fclose(file);
        $display("Estado: %b [IDLE] = Imagem escrita em ../Imagens/LogImagens/zanagotchi_idle1.hex", estado);

        // DORMINDO
        estado = 4'b0001;
        #3000;
        file = $fopen("../Imagens/LogImagens/zanagotchi_dormindo1.hex", "w");

        for (integer i = 0; i < 1023; i = i + 1)
            $fwrite(file, "%02x ", imagem[i*8 +: 8]);
        $fwrite(file, "%02x", imagem[1023*8 +: 8]);  // Último byte sem espaço

        $fclose(file);
        $display("Estado: %b [DORMINDO] = Imagem escrita em ../Imagens/LogImagens/zanagotchi_dormindo1.hex", estado);

        // COMENDO
        estado = 4'b0010;
        #10;
        file = $fopen("../Imagens/LogImagens/zanagotchi_comendo1.hex", "w");

        for (integer i = 0; i < 1023; i = i + 1)
            $fwrite(file, "%02x ", imagem[i*8 +: 8]);
        $fwrite(file, "%02x", imagem[1023*8 +: 8]);  // Último byte sem espaço

        $fclose(file);
        $display("Estado: %b [COMENDO] = Imagem escrita em ../Imagens/LogImagens/zanagotchi_comendo1.hex", estado);

        // DANDO_AULA
        estado = 4'b0011;
        #10;
        file = $fopen("../Imagens/LogImagens/zanagotchi_dando_aula1.hex", "w");

        for (integer i = 0; i < 1023; i = i + 1)
            $fwrite(file, "%02x ", imagem[i*8 +: 8]);
        $fwrite(file, "%02x", imagem[1023*8 +: 8]);  // Último byte sem espaço

        $fclose(file);
        $display("Estado: %b [DANDO_AULA] = Imagem escrita em ../Imagens/LogImagens/zanagotchi_dando_aula1.hex", estado);

        // MORTO
        estado = 4'b0100;
        #10;
        file = $fopen("../Imagens/LogImagens/zanagotchi_morto1.hex", "w");

        for (integer i = 0; i < 1023; i = i + 1)
            $fwrite(file, "%02x ", imagem[i*8 +: 8]);
        $fwrite(file, "%02x", imagem[1023*8 +: 8]);  // Último byte sem espaço

        $fclose(file);
        $display("Estado: %b [MORTO] = Imagem escrita em ../Imagens/LogImagens/zanagotchi_morto1.hex", estado);

        $finish;
    end

endmodule
