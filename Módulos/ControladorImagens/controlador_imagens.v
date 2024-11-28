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
    reg[7:0] memoria_imagens[0:1023];  // 5 imagens de 1024 bytes cada -- AUMENTAR QUANDO TIVER MAIS IMGS

    // Inicializa a memória
    initial 
    begin
//        $readmemh("./Imagens/hexs/Idle/zanagotchi_idle1.hex", memoria_imagens, 0, 1023);
        $readmemh("./Imagens/hexs/Dormindo/zanagotchi_dormindo1.hex", memoria_imagens, 0, 1023);
//        $readmemh("./Imagens/hexs/Comendo/zanagotchi_comendo1.hex", memoria_imagens, 2*1024, 2*1024 + 1023);
//        $readmemh("./Imagens/hexs/DandoAula/zanagotchi_dando_aula1.hex", memoria_imagens, 3*1024, 3*1024 + 1023);
//        $readmemh("./Imagens/hexs/Morto/zanagotchi_morto1.hex", memoria_imagens, 4*1024, 4*1024 + 1023);
    end

    integer i;
//    reg [10:0] index_memoria = 0;

    // Atualização de imagens baseada no estado
    always @(posedge clk) 
    begin : ImagensBlock

//        case (estado)
//            IDLE: index_memoria <= 0*1024;
//            DORMINDO: index_memoria <= 0*1024;
//            COMENDO: index_memoria <= 0*1024;
//            DANDO_AULA: index_memoria <= 0*1024;
//            MORTO: index_memoria <= 0*1024;
//            default: index_memoria <= index_memoria;
//        endcase

        // Copia os dados da memória para a saída
        for (i = 0; i < 1024; i = i + 1)
            imagem[i*8 +: 8] <= memoria_imagens[i];
    end
endmodule
