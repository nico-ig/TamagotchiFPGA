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
               DANDO_AULA = 4'b0011,
               MORTO = 4'b0100;

    // Memória para armazenar todas as imagens inicialmente
    reg[7:0] memoria_idle[0:1023][0:0];
    reg[7:0] memoria_dormindo[0:1023][0:0];
    reg[7:0] memoria_comendo[0:1023][0:0];
    reg[7:0] memoria_dando_aula[0:1023][0:0];
    reg[7:0] memoria_morto[0:1023][0:0];
    reg[7:0] tmp[0:1023];

    // Inicializa a memória
    initial 
    begin
        $readmemh("../Imagens/hexs/Idle/zanagotchi_idle1.hex", tmp);
        for (integer i = 0; i < 1024; i = i + 1)
            memoria_idle[i][0] = tmp[i];
        $readmemh("../Imagens/hexs/Dormindo/zanagotchi_dormindo1.hex", tmp);
        for (integer i = 0; i < 1024; i = i + 1)
            memoria_dormindo[i][0] = tmp[i];
        $readmemh("../Imagens/hexs/Comendo/zanagotchi_comendo1.hex", tmp);
        for (integer i = 0; i < 1024; i = i + 1)
            memoria_comendo[i][0] = tmp[i];
        $readmemh("../Imagens/hexs/DandoAula/zanagotchi_dando_aula1.hex", tmp);
        for (integer i = 0; i < 1024; i = i + 1)
            memoria_dando_aula[i][0] = tmp[i];
        $readmemh("../Imagens/hexs/Morto/zanagotchi_morto1.hex", tmp);
        for (integer i = 0; i < 1024; i = i + 1)
            memoria_morto[i][0] = tmp[i];
    end

    // Atualização de imagens baseada no estado
    always @* 
    begin
        case (estado)
            IDLE: 
            for (integer i = 0; i < 1024; i = i + 1)
                imagem[i*8 +: 8] <= memoria_idle[i][0];
            DORMINDO:
            for (integer i = 0; i < 1024; i = i + 1)
                imagem[i*8 +: 8] <= memoria_dormindo[i][0];
            COMENDO:
            for (integer i = 0; i < 1024; i = i + 1)
                imagem[i*8 +: 8] <= memoria_comendo[i][0];
            DANDO_AULA:
            for (integer i = 0; i < 1024; i = i + 1)
                imagem[i*8 +: 8] <= memoria_dando_aula[i][0];
            MORTO:
            for (integer i = 0; i < 1024; i = i + 1)
                imagem[i*8 +: 8] <= memoria_morto[i][0];
            default:
            for (integer i = 0; i < 1024; i = i + 1)
                imagem[i*8 +: 8] <= imagem[i];
        endcase

    end
endmodule
