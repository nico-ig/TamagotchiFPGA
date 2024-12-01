module controlador_imagens
(
    input wire clk,
    input wire [9:0] byte_counter,
    input wire [3:0] estado,
    output reg [7:0] data_to_send
);

    reg [7:0] felicidade, fome, sono;

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100,
               MORTO = 4'b1000;

    localparam IDLE_SIZE = 6,
               DORMINDO_SIZE = 4,
               COMENDO_SIZE = 5,
               DANDO_AULA_SIZE = 7,
               MORTO_SIZE = 8;

    // Memória para armazenar todas as imagens inicialmente
    reg[7:0] memoria_idle_0 [0:1023];
    reg[7:0] memoria_idle_1 [0:1023];
    reg[7:0] memoria_idle_2 [0:1023];
    reg[7:0] memoria_idle_3 [0:1023];
    reg[7:0] memoria_idle_4 [0:1023];
    reg[7:0] memoria_idle_5 [0:1023];

    reg[7:0] memoria_dormindo_0 [0:1023];
    reg[7:0] memoria_dormindo_1 [0:1023];
    reg[7:0] memoria_dormindo_2 [0:1023];
    reg[7:0] memoria_dormindo_3 [0:1023];

    reg[7:0] memoria_comendo_0 [0:1023];
    reg[7:0] memoria_comendo_1 [0:1023];
    reg[7:0] memoria_comendo_2 [0:1023];
    reg[7:0] memoria_comendo_3 [0:1023];
    reg[7:0] memoria_comendo_4 [0:1023];

    reg[7:0] memoria_dando_aula_0 [0:1023];
    reg[7:0] memoria_dando_aula_1 [0:1023];
    reg[7:0] memoria_dando_aula_2 [0:1023];
    reg[7:0] memoria_dando_aula_3 [0:1023];
    reg[7:0] memoria_dando_aula_4 [0:1023];
    reg[7:0] memoria_dando_aula_5 [0:1023];
    reg[7:0] memoria_dando_aula_6 [0:1023];

    reg[7:0] memoria_morto_0 [0:1023];
    reg[7:0] memoria_morto_1 [0:1023];
    reg[7:0] memoria_morto_2 [0:1023];
    reg[7:0] memoria_morto_3 [0:1023];
    reg[7:0] memoria_morto_4 [0:1023];
    reg[7:0] memoria_morto_5 [0:1023];
    reg[7:0] memoria_morto_6 [0:1023];
    reg[7:0] memoria_morto_7 [0:1023];

    // Inicializa a memória
    initial
    begin
        felicidade = 34;
        fome = 22;
        sono = 84;

        $readmemh("hexs/Idle/zanagotchi_idle1.hex", memoria_idle_0);
        $readmemh("hexs/Idle/zanagotchi_idle2.hex", memoria_idle_1);
        $readmemh("hexs/Idle/zanagotchi_idle3.hex", memoria_idle_2);
        $readmemh("hexs/Idle/zanagotchi_idle4.hex", memoria_idle_3);
        $readmemh("hexs/Idle/zanagotchi_idle5.hex", memoria_idle_4);
        $readmemh("hexs/Idle/zanagotchi_idle6.hex", memoria_idle_5);

        $readmemh("hexs/Dormindo/zanagotchi_dormindo1.hex", memoria_dormindo_0);
        $readmemh("hexs/Dormindo/zanagotchi_dormindo2.hex", memoria_dormindo_1);
        $readmemh("hexs/Dormindo/zanagotchi_dormindo3.hex", memoria_dormindo_2);
        $readmemh("hexs/Dormindo/zanagotchi_dormindo4.hex", memoria_dormindo_3);

        $readmemh("hexs/Comendo/zanagotchi_comendo1.hex", memoria_comendo_0);
        $readmemh("hexs/Comendo/zanagotchi_comendo2.hex", memoria_comendo_1);
        $readmemh("hexs/Comendo/zanagotchi_comendo3.hex", memoria_comendo_2);
        $readmemh("hexs/Comendo/zanagotchi_comendo4.hex", memoria_comendo_3);
        $readmemh("hexs/Comendo/zanagotchi_comendo5.hex", memoria_comendo_4);

        $readmemh("hexs/DandoAula/zanagotchi_dando_aula1.hex", memoria_dando_aula_0);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula2.hex", memoria_dando_aula_1);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula3.hex", memoria_dando_aula_2);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula4.hex", memoria_dando_aula_3);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula5.hex", memoria_dando_aula_4);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula6.hex", memoria_dando_aula_5);
        $readmemh("hexs/DandoAula/zanagotchi_dando_aula7.hex", memoria_dando_aula_6);

        $readmemh("hexs/Morto/zanagotchi_morto1.hex", memoria_morto_0);
        $readmemh("hexs/Morto/zanagotchi_morto2.hex", memoria_morto_1);
        $readmemh("hexs/Morto/zanagotchi_morto3.hex", memoria_morto_2);
        $readmemh("hexs/Morto/zanagotchi_morto4.hex", memoria_morto_3);
        $readmemh("hexs/Morto/zanagotchi_morto5.hex", memoria_morto_4);
        $readmemh("hexs/Morto/zanagotchi_morto6.hex", memoria_morto_5);
        $readmemh("hexs/Morto/zanagotchi_morto7.hex", memoria_morto_6);
        $readmemh("hexs/Morto/zanagotchi_morto8.hex", memoria_morto_7);
    end

    reg [22:0] frame_counter = 23'd1;
   
    reg [2:0] i_idle = 0;
    reg [2:0] i_dormindo = 0;
    reg [2:0] i_comendo = 0;
    reg [2:0] i_dando_aula = 0;
    reg [2:0] i_morto = 0;

    reg [9:0] byte_counter_idle = 0;
    reg[3:0] idle_offset = 0;
    reg offset_idle_counter = 0;

    always @(posedge clk) begin
        byte_counter_idle <= byte_counter + idle_offset * (byte_counter > 10'd300);
    end

    always @(posedge clk) begin 
        frame_counter <= frame_counter + 23'd1;
        if (frame_counter == 0) begin
            offset_idle_counter <= offset_idle_counter + 1;
            if (offset_idle_counter == 0) idle_offset <= idle_offset + 4'd8;
            
            i_idle <= 3'd5;
            i_dormindo <= (i_dormindo + 1) % DORMINDO_SIZE;
            i_comendo <= (i_comendo + 1) % COMENDO_SIZE;
            i_dando_aula <= (i_dando_aula + 1) % DANDO_AULA_SIZE;
            i_morto <= (i_morto + 1) % MORTO_SIZE;
        end
    end

    // Atualização de imagens baseada no estado
    always @(posedge clk) 
    begin

        //==================================== FELICIDADE ====================================

        if (byte_counter == 65 ||     //  8 * 8 + 1 = 65
            byte_counter == 73 ||     //  9 * 8 + 1 = 73
            byte_counter == 81 ||     // 10 * 8 + 1 = 81
            byte_counter == 89 ||     // 11 * 8 + 1 = 89
            byte_counter == 97) begin // 12 * 8 + 1 = 97
            if (felicidade > 90)
                data_to_send <= 8'b11101110;
            else if (felicidade > 80)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end 
        else if (byte_counter == 66 || //  8 * 8 + 2 = 66
            byte_counter == 74 ||      //  9 * 8 + 2 = 74
            byte_counter == 82 ||      // 10 * 8 + 2 = 82
            byte_counter == 90 ||      // 11 * 8 + 2 = 90
            byte_counter == 98) begin  // 12 * 8 + 2 = 98
            if (felicidade > 70)
                data_to_send <= 8'b11101110;
            else if (felicidade > 60)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 67 || //  8 * 8 + 3 = 67
            byte_counter == 75 ||      //  9 * 8 + 3 = 75
            byte_counter == 83 ||      // 10 * 8 + 3 = 83
            byte_counter == 91 ||      // 11 * 8 + 3 = 91
            byte_counter == 99) begin  // 12 * 8 + 3 = 99
            if (felicidade > 50)
                data_to_send <= 8'b11101110;
            else if (felicidade > 40)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 68 || //  8 * 8 + 4 = 68
            byte_counter == 76 ||      //  9 * 8 + 4 = 76
            byte_counter == 84 ||      // 10 * 8 + 4 = 84
            byte_counter == 92 ||      // 11 * 8 + 4 = 92
            byte_counter == 100) begin // 12 * 8 + 4 = 100
            if (felicidade > 30)
                data_to_send <= 8'b11101110;
            else if (felicidade > 20)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 69 || //  8 * 8 + 5 = 69
            byte_counter == 77 ||      //  9 * 8 + 5 = 77
            byte_counter == 85 ||      // 10 * 8 + 5 = 85
            byte_counter == 93 ||      // 11 * 8 + 5 = 93
            byte_counter == 101) begin // 12 * 8 + 5 = 101
            if (felicidade > 10)
                data_to_send <= 8'b11101110;
            else if (felicidade > 0)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end

        //======================================= FOME =======================================
        
        else if (byte_counter == 145 || // 18 * 8 + 1 = 145
            byte_counter == 153 ||      // 19 * 8 + 1 = 153
            byte_counter == 161 ||      // 20 * 8 + 1 = 161
            byte_counter == 169 ||      // 21 * 8 + 1 = 169
            byte_counter == 177) begin  // 22 * 8 + 1 = 177
            if (fome > 90)
                data_to_send <= 8'b11101110;
            else if (fome > 80)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end 
        else if (byte_counter == 146 || // 18 * 8 + 2 = 146
            byte_counter == 154 ||      // 19 * 8 + 2 = 154
            byte_counter == 162 ||      // 20 * 8 + 2 = 162
            byte_counter == 170 ||      // 21 * 8 + 2 = 170
            byte_counter == 178) begin  // 22 * 8 + 2 = 178
            if (fome > 70)
                data_to_send <= 8'b11101110;
            else if (fome > 60)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 147 || // 18 * 8 + 3 = 147
            byte_counter == 155 ||      // 19 * 8 + 3 = 155
            byte_counter == 163 ||      // 20 * 8 + 3 = 163
            byte_counter == 171 ||      // 21 * 8 + 3 = 171
            byte_counter == 179) begin  // 22 * 8 + 3 = 179
            if (fome > 50)
                data_to_send <= 8'b11101110;
            else if (fome > 40)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 148 || // 18 * 8 + 4 = 148
            byte_counter == 156 ||      // 19 * 8 + 4 = 156
            byte_counter == 164 ||      // 20 * 8 + 4 = 164
            byte_counter == 172 ||      // 21 * 8 + 4 = 172
            byte_counter == 180) begin  // 22 * 8 + 4 = 180
            if (fome > 30)
                data_to_send <= 8'b11101110;
            else if (fome > 20)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 149 || // 18 * 8 + 5 = 149
            byte_counter == 157 ||      // 19 * 8 + 5 = 157
            byte_counter == 165 ||      // 20 * 8 + 5 = 165
            byte_counter == 173 ||      // 21 * 8 + 5 = 173
            byte_counter == 181) begin  // 22 * 8 + 5 = 181
            if (fome > 10)
                data_to_send <= 8'b11101110;
            else if (fome > 0)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end

        //======================================= SONO =======================================

        else if (byte_counter == 225 || // 28 * 8 + 1 = 225
            byte_counter == 233 ||      // 29 * 8 + 1 = 233
            byte_counter == 241 ||      // 30 * 8 + 1 = 241
            byte_counter == 249 ||      // 31 * 8 + 1 = 249
            byte_counter == 257) begin  // 32 * 8 + 1 = 257
            if (sono > 90)
                data_to_send <= 8'b11101110;
            else if (sono > 80)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end 
        else if (byte_counter == 226 || // 28 * 8 + 2 = 226
            byte_counter == 234 ||      // 29 * 8 + 2 = 234
            byte_counter == 242 ||      // 30 * 8 + 2 = 242
            byte_counter == 250 ||      // 31 * 8 + 2 = 250
            byte_counter == 258) begin  // 32 * 8 + 2 = 258
            if (sono > 70)
                data_to_send <= 8'b11101110;
            else if (sono > 60)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 227 || // 28 * 8 + 3 = 227
            byte_counter == 235 ||      // 29 * 8 + 3 = 235
            byte_counter == 243 ||      // 30 * 8 + 3 = 243
            byte_counter == 251 ||      // 31 * 8 + 3 = 251
            byte_counter == 259) begin  // 32 * 8 + 3 = 259
            if (sono > 50)
                data_to_send <= 8'b11101110;
            else if (sono > 40)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 228 || // 28 * 8 + 4 = 228
            byte_counter == 236 ||      // 29 * 8 + 4 = 236
            byte_counter == 244 ||      // 30 * 8 + 4 = 244
            byte_counter == 252 ||      // 31 * 8 + 4 = 252
            byte_counter == 260) begin  // 32 * 8 + 4 = 260
            if (sono > 30)
                data_to_send <= 8'b11101110;
            else if (sono > 20)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end
        else if (byte_counter == 229 || // 28 * 8 + 5 = 229
            byte_counter == 237 ||      // 29 * 8 + 5 = 237
            byte_counter == 245 ||      // 30 * 8 + 5 = 245
            byte_counter == 253 ||      // 31 * 8 + 5 = 253
            byte_counter == 261) begin  // 32 * 8 + 5 = 261
            if (sono > 10)
                data_to_send <= 8'b11101110;
            else if (sono > 0)
                data_to_send <= 8'b11100000;
            else
                data_to_send <= 0;
        end else

        begin
            case (estado)
                IDLE:
                begin
                    case (i_idle)
                    3'd0: data_to_send <= memoria_idle_0[byte_counter_idle];
                    3'd1: data_to_send <= memoria_idle_1[byte_counter_idle];
                    3'd2: data_to_send <= memoria_idle_2[byte_counter_idle];
                    3'd3: data_to_send <= memoria_idle_3[byte_counter_idle];
                    3'd4: data_to_send <= memoria_idle_4[byte_counter_idle];
                    3'd5: data_to_send <= memoria_idle_5[byte_counter_idle];
                    default: data_to_send <= 0;
                    endcase
                end
                DORMINDO:
                begin
                    case (i_dormindo)
                    3'd0: data_to_send <= memoria_dormindo_0[byte_counter];
                    3'd1: data_to_send <= memoria_dormindo_1[byte_counter];
                    3'd2: data_to_send <= memoria_dormindo_2[byte_counter];
                    3'd3: data_to_send <= memoria_dormindo_3[byte_counter];
                    default: data_to_send <= 0;
                    endcase
                end
                COMENDO:
                begin
                    case (i_comendo)
                    3'd0: data_to_send <= memoria_comendo_0[byte_counter];
                    3'd1: data_to_send <= memoria_comendo_1[byte_counter];
                    3'd2: data_to_send <= memoria_comendo_2[byte_counter];
                    3'd3: data_to_send <= memoria_comendo_3[byte_counter];
                    3'd4: data_to_send <= memoria_comendo_4[byte_counter];
                    default: data_to_send <= 0;
                    endcase
                end
                DANDO_AULA:
                begin
                    case (i_dando_aula)
                    3'd0: data_to_send <= memoria_dando_aula_0[byte_counter];
                    3'd1: data_to_send <= memoria_dando_aula_1[byte_counter];
                    3'd2: data_to_send <= memoria_dando_aula_2[byte_counter];
                    3'd3: data_to_send <= memoria_dando_aula_3[byte_counter];
                    3'd4: data_to_send <= memoria_dando_aula_4[byte_counter];
                    3'd5: data_to_send <= memoria_dando_aula_5[byte_counter];
                    3'd6: data_to_send <= memoria_dando_aula_6[byte_counter];
                    default: data_to_send <= 0;
                    endcase
                end
                MORTO:
                begin
                    case (i_morto)
                    3'd0: data_to_send <= memoria_morto_0[byte_counter];
                    3'd1: data_to_send <= memoria_morto_1[byte_counter];
                    3'd2: data_to_send <= memoria_morto_2[byte_counter];
                    3'd3: data_to_send <= memoria_morto_3[byte_counter];
                    3'd4: data_to_send <= memoria_morto_4[byte_counter];
                    3'd5: data_to_send <= memoria_morto_5[byte_counter];
                    3'd6: data_to_send <= memoria_morto_6[byte_counter];
                    3'd7: data_to_send <= memoria_morto_6[byte_counter];
                    default data_to_send <= 0;
                    endcase
                end
                default: data_to_send <= 0;
            endcase
        end 
    end

endmodule
