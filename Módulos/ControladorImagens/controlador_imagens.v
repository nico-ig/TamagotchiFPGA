module controlador_imagens
(
    input wire [3:0] estado,
    output wire [1024*8-1:0] imagem
);
    integer i, j;

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0011,
               MORTO = 4'b0100;

    // Memória para armazenar todas as imagens inicialmente
    reg[1024*8-1:0] memoria_idle[0:0];
    reg[1024*8-1:0] memoria_dormindo[0:0];
    reg[1024*8-1:0] memoria_comendo[0:0];
    reg[1024*8-1:0] memoria_dando_aula[0:0];
    reg[1024*8-1:0] memoria_morto[0:0];
    reg[7:0] tmp[0:1023];

    // Inicializa a memória
    initial 
    begin
        $readmemh("./Imagens/hexs/Idle/zanagotchi_idle1.hex", tmp);
        for (i = 0; i < 1024; i = i + 1)
            for (j = 0; j < 8; j = j + 1)
                memoria_idle[0][i*8 + j] = tmp[i][j];
        $readmemh("./Imagens/hexs/Dormindo/zanagotchi_dormindo1.hex", tmp);
        for (i = 0; i < 1024; i = i + 1)
            for (j = 0; j < 8; j = j + 1)
                memoria_dormindo[0][i*8 + j] = tmp[i][j];
        $readmemh("./Imagens/hexs/Comendo/zanagotchi_comendo1.hex", tmp);
        for (i = 0; i < 1024; i = i + 1)
            for (j = 0; j < 8; j = j + 1)
                memoria_comendo[0][i*8 + j] = tmp[i][j];
        $readmemh("./Imagens/hexs/DandoAula/zanagotchi_dando_aula1.hex", tmp);
        for (i = 0; i < 1024; i = i + 1)
            for (j = 0; j < 8; j = j + 1)
                memoria_dando_aula[0][i*8 + j] = tmp[i][j];
        $readmemh("./Imagens/hexs/Morto/zanagotchi_morto1.hex", tmp);
        for (i = 0; i < 1024; i = i + 1) 
            for (j = 0; j < 8; j = j + 1)
                memoria_morto[0][i*8 + j] = tmp[i][j];
    end

    // Atualização de imagens baseada no estado
    assign imagem = (estado == IDLE) ? memoria_idle[0] :
                (estado == DORMINDO) ? memoria_dormindo[0] :
                (estado == COMENDO) ? memoria_comendo[0] :
                (estado == DANDO_AULA) ? memoria_dando_aula[0] :
                (estado == MORTO) ? memoria_morto[0] :
                memoria_idle[0];

endmodule
