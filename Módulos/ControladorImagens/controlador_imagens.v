module controlador_imagens
(
    input wire clk,
    input wire [9:0] byte_counter,
    input wire [3:0] estado,
    output reg [7:0] data_to_send
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
        $readmemh("hexs/Idle/zanagotchi_idle1.hex", memoria_idle, );
        $readmemh("hexs/Dormindo/zanagotchi_dormindo1.hex", memoria_dormindo, 0, 1023);
        $readmemh("hexs/Comendo/zanagotchi_comendo1.hex", memoria_comendo, 0, 1023);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula1.hex", memoria_dando_aula, 0, 1023);
        $readmemh("hexs/Morto/zanagotchi_morto1.hex", memoria_morto, 0, 1023);
    end

    // Atualização de imagens baseada no estado
    always @(posedge clk) 
    begin
        case (estado)
            IDLE: data_to_send <= memoria_idle[byte_counter];
            DORMINDO: data_to_send <= memoria_dormindo[byte_counter];
            COMENDO: data_to_send <= memoria_comendo[byte_counter];
            DANDO_AULA: data_to_send <= memoria_dando_aula[byte_counter];
            MORTO: data_to_send <= memoria_morto[byte_counter];
            default: data_to_send <= memoria_idle[byte_counter];
        endcase
        
    end

endmodule
