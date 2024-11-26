module controlador_imagens
(
    input wire clk,
    input wire[3:0] estado,
    output reg[1024*8-1:0] imagem
);

    // Instancia display
    controlador_display DIS
    (
        .clk(clk),
        .image(imagem)
    );

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100,
               MORTO = 4'b1000;

    // Memória para a imagem
    reg[7:0] imagem_mem[0:1023];

    // Atualização de imagens
    always @(posedge clk) 
    begin
        case (estado)

            IDLE:
            begin
                $readmemh("../../Imagens/hexs/Idle/zanagotchi_idle1.hex", imagem_mem);
            end

            DORMINDO:
            begin
                $readmemh("../../Imagens/hexs/Dormindo/zanagotchi_dormindo1.hex", imagem_mem);

            end

            COMENDO:
            begin
                $readmemh("../../Imagens/hexs/Comendo/zanagotchi_comendo1.hex", imagem_mem);
            end

            DANDO_AULA:
            begin
                $readmemh("../../Imagens/hexs/DandoAula/zanagotchi_dando_aula1.hex", imagem_mem);
            end

            MORTO:
            begin
                $readmemh("../../Imagens/hexs/Morto/zanagotchi_morto1.hex", imagem_mem);
            end

            default: $readmemh("../../Imagens/hexs/Intro/zanagotchi_intro1.hex", imagem_mem);
        endcase

        // Copia os dados da memória para a saída
        for (integer i = 0; i < 1024; i = i + 1) 
            imagem[i*8 +: 8] = imagem_mem[i];
    end
endmodule
