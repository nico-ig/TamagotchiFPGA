module controlador_imagens
(
    input wire clk,
    input wire [9:0] byte_counter,
    input wire [3:0] estado,
    output reg [7:0] data_to_send
);

    reg [7:0] felicidade, fome, sono;

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
        felicidade = 100;
        fome = 100;
        sono = 100;

        $readmemh("hexs/Idle/zanagotchi_idle1.hex", memoria_idle, 0, 1023);
        $readmemh("hexs/Dormindo/zanagotchi_dormindo1.hex", memoria_dormindo, 0, 1023);
        $readmemh("hexs/Comendo/zanagotchi_comendo1.hex", memoria_comendo, 0, 1023);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula1.hex", memoria_dando_aula, 0, 1023);
        $readmemh("hexs/Morto/zanagotchi_morto1.hex", memoria_morto, 0, 1023);
    end

    // Atualização de imagens baseada no estado
    always @(posedge clk) 
    begin
        if ((byte_counter >= 8 * 8 + 1 && byte_counter <= 8 * 8 + 5) ||
            (byte_counter >= 9 * 8 + 1 && byte_counter <= 9 * 8 + 5) ||
            (byte_counter >= 10 * 8 + 1 && byte_counter <= 10 * 8 + 5) ||
            (byte_counter >= 11 * 8 + 1 && byte_counter <= 11 * 8 + 5) ||
            (byte_counter >= 12 * 8 + 1 && byte_counter <= 12 * 8 + 5)) begin
            if (byte_counter%8 == 1) begin
                if (felicidade > 90)
                    data_to_send <= 8'b11101110;
                else if (felicidade > 80)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 2) begin
                if (felicidade > 70)
                    data_to_send <= 8'b11101110;
                else if (felicidade > 60)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 3) begin
                if (felicidade > 50)
                    data_to_send <= 8'b11101110;
                else if (felicidade > 40)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 4) begin
                if (felicidade > 30)
                    data_to_send <= 8'b11101110;
                else if (felicidade > 20)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 5) begin
                if (felicidade > 10)
                    data_to_send <= 8'b11101110;
                else if (felicidade > 0)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
        end
        else if ((byte_counter >= 18 * 8 + 1 && byte_counter <= 18 * 8 + 5) ||
            (byte_counter >= 19 * 8 + 1 && byte_counter <= 19 * 8 + 5) ||
            (byte_counter >= 20 * 8 + 1 && byte_counter <= 20 * 8 + 5) ||
            (byte_counter >= 21 * 8 + 1 && byte_counter <= 21 * 8 + 5) ||
            (byte_counter >= 22 * 8 + 1 && byte_counter <= 22 * 8 + 5)) begin
            if (byte_counter%8 == 1) begin
                if (fome > 90)
                    data_to_send <= 8'b11101110;
                else if (fome > 80)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 2) begin
                if (fome > 70)
                    data_to_send <= 8'b11101110;
                else if (fome > 60)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 3) begin
                if (fome > 50)
                    data_to_send <= 8'b11101110;
                else if (fome > 40)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 4) begin
                if (fome > 30)
                    data_to_send <= 8'b11101110;
                else if (fome > 20)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 5) begin
                if (fome > 10)
                    data_to_send <= 8'b11101110;
                else if (fome > 0)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
        end
        else if ((byte_counter >= (28 * 8 + 1) && byte_counter <= (28 * 8 + 5)) ||
            (byte_counter >= 29 * 8 + 1 && byte_counter <= 29 * 8 + 5) ||
            (byte_counter >= 30 * 8 + 1 && byte_counter <= 30 * 8 + 5) ||
            (byte_counter >= 31 * 8 + 1 && byte_counter <= 31 * 8 + 5) ||
            (byte_counter >= 32 * 8 + 1 && byte_counter <= 32 * 8 + 5)) begin
            if (byte_counter%8 == 1) begin
                if (sono > 90)
                    data_to_send <= 8'b11101110;
                else if (sono > 80)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 2) begin
                if (sono > 70)
                    data_to_send <= 8'b11101110;
                else if (sono > 60)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 3) begin
                if (sono > 50)
                    data_to_send <= 8'b11101110;
                else if (sono > 40)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 4) begin
                if (sono > 30)
                    data_to_send <= 8'b11101110;
                else if (sono > 20)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
            if (byte_counter%8 == 5) begin
                if (sono > 10)
                    data_to_send <= 8'b11101110;
                else if (sono > 0)
                    data_to_send <= 8'b11100000;
                else
                    data_to_send <= 0;
            end
        end
        else begin

            case (estado)
                IDLE: data_to_send <= 0; //memoria_idle[byte_counter];
                DORMINDO: data_to_send <= 0; //memoria_dormindo[byte_counter];
                COMENDO: data_to_send <= 0; //memoria_comendo[byte_counter];
                DANDO_AULA: data_to_send <= 0; //memoria_dando_aula[byte_counter];
                MORTO: data_to_send <= 0; //memoria_morto[byte_counter];
                default: data_to_send <= 0; //memoria_idle[byte_counter];
            endcase
        end
        
    end

endmodule
