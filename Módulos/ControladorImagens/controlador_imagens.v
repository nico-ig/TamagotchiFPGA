module controlador_imagens
(
    input wire clk,
    input wire [3:0] estado,
    output reg [1024*8-1:0] imagem
);
    integer i;

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100,
               MORTO = 4'b1000;

    localparam IDLE_SIZE = 1,
               DORMINDO_SIZE = 1,
               COMENDO_SIZE = 1,
               DANDO_AULA_SIZE = 1,
               MORTO_SIZE = 1;

    // Memória para armazenar todas as imagens inicialmente
    reg[7:0] memoria_idle [0:IDLE_SIZE*1023];
    reg[7:0] memoria_dormindo [0:DORMINDO_SIZE*1023];
    reg[7:0] memoria_comendo [0:COMENDO_SIZE*1023];
    reg[7:0] memoria_dando_aula [0:DANDO_AULA_SIZE*1023];
    reg[7:0] memoria_morto [0:MORTO_SIZE*1023];

    // Inicializa a memória
    initial
    begin
        for (i = 0; i < IDLE_SIZE; i = i + 1) begin
            $readmemh($sformatf("/hexs/Idle/zanagotchi_idle%0d.hex", i + 1), memoria_idle, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < DORMINDO_SIZE; i = i + 1) begin
            $readmemh($sformatf("/hexs/Dormindo/zanagotchi_dormindo%0d.hex", i + 1), memoria_dormindo, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < COMENDO_SIZE; i = i + 1) begin
            $readmemh($sformatf("/hexs/Comendo/zanagotchi_comendo%0d.hex", i + 1), memoria_comendo, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < DANDO_AULA_SIZE; i = i + 1) begin
            $readmemh($sformatf("/hexs/DandoAula/zanagotchi_dando_aula%0d.hex", i + 1), memoria_dando_aula, i*1024, i*1024 + 1023);
        end

        for (i = 0; i < MORTO_SIZE; i = i + 1) begin
            $readmemh($sformatf("/hexs/Morto/zanagotchi_morto%0d.hex", i + 1), memoria_morto, i*1024, i*1024 + 1023);
        end
    end

    // Atualização de imagens baseada no estado
    always @(posedge clk) 
    begin : ImagensBlock

        // Copia a imagem para a saida
        case (estado)
            IDLE: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= memoria_idle[i];
            end
            DORMINDO:
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= memoria_dormindo[i];
            end
            COMENDO: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= memoria_comendo[i];
            end
            DANDO_AULA: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= memoria_dando_aula[i];
            end
            MORTO: 
            begin
                for (i = 0; i < 1024; i = i + 1)
                    imagem[i*8 +: 8] <= memoria_morto[i];
            end
            default: imagem <= imagem;
        endcase
    end

endmodule
