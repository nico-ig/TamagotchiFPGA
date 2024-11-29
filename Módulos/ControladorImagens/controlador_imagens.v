module controlador_imagens
(
    input wire clk,
    input wire [3:0] estado,
    output wire [1024*8-1:0] imagem
);
    integer i;

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0011,
               MORTO = 4'b0100;

    localparam IDLE_SIZE = 1,
               DORMINDO_SIZE = 1,
               COMENDO_SIZE = 1,
               DANDO_AULA_SIZE = 1,
               MORTO_SIZE = 1;

    // Memória para armazenar todas as imagens inicialmente
    reg[7:0] memoria_idle [IDLE_SIZE*1023:0];
    reg[7:0] memoria_dormindo [DORMINDO_SIZE*1023:0];
    reg[7:0] memoria_comendo [COMENDO_SIZE*1023:0];
    reg[7:0] memoria_dando_aula [DANDO_AULA_SIZE*1023:0];
    reg[7:0] memoria_morto [MORTO_SIZE*1023:0];

    // Inicializa a memória
    initial
    begin
        for (i = 0; i < IDLE_SIZE; i = i + 1) begin
            $readmemh($sformatf("../Imagens/hexs/Idle/zanagotchi_idle%0d.hex", i + 1), memoria_idle, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < DORMINDO_SIZE; i = i + 1) begin
            $readmemh($sformatf("../Imagens/hexs/Dormindo/zanagotchi_dormindo%0d.hex", i + 1), memoria_dormindo, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < COMENDO_SIZE; i = i + 1) begin
            $readmemh($sformatf("../Imagens/hexs/Comendo/zanagotchi_comendo%0d.hex", i + 1), memoria_comendo, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < DANDO_AULA_SIZE; i = i + 1) begin
            $readmemh($sformatf("../Imagens/hexs/DandoAula/zanagotchi_dando_aula%0d.hex", i + 1), memoria_dando_aula, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < MORTO_SIZE; i = i + 1) begin
            $readmemh($sformatf("../Imagens/hexs/Morto/zanagotchi_morto%0d.hex", i + 1), memoria_morto, i*1024, i*1024 + 1023);
        end
    end

    // Atualização de imagens baseada no estado
    assign imagem = (estado == IDLE) ? memoria_idle[0] :
                (estado == DORMINDO) ? memoria_dormindo[0] :
                (estado == COMENDO) ? memoria_comendo[0] :
                (estado == DANDO_AULA) ? memoria_dando_aula[0] :
                (estado == MORTO) ? memoria_morto[0] :
                memoria_idle[0];

endmodule
