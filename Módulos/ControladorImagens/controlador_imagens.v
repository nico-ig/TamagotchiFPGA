module controlador_imagens
(
    input wire clk,
    input wire [3:0] estado,
    output reg [1024*8-1:0] imagem
);

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100,
               MORTO = 4'b1000;

    // Memória para armazenar todas as imagens inicialmente
    reg[7:0] idle1[0:1023];
    reg[7:0] dormindo1[0:1023];
    reg[7:0] comendo1[0:1023];
    reg[7:0] aula1[0:1023];
    reg[7:0] morto1[0:1023];

    // Inicializa a memória
    initial 
    begin
        $readmemh("./Imagens/hexs/Idle/zanagotchi_idle1.hex", idle1, 0, 1023);
        $readmemh("./Imagens/hexs/Dormindo/zanagotchi_dormindo1.hex", dormindo1, 0, 1023);
        $readmemh("./Imagens/hexs/Comendo/zanagotchi_comendo1.hex", comendo1, 0, 1023);
        $readmemh("./Imagens/hexs/DandoAula/zanagotchi_dando_aula1.hex", aula1, 0, 1023);
        $readmemh("./Imagens/hexs/Morto/zanagotchi_morto1.hex", morto1, 0, 1023);
    end

    integer i;

    // Atualização de imagens baseada no estado
    always @(posedge clk) 
    begin : ImagensBlock

        // Copia a imagem para a saida
        case (estado)
            IDLE: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= idle1[i];
            end
            DORMINDO:
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= dormindo1[i];
            end
            COMENDO: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= comendo1[i];
            end
            DANDO_AULA: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= aula1[i];
            end
            MORTO: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= morto1[i];
            end
            default: imagem <= imagem;
        endcase
    end
endmodule
