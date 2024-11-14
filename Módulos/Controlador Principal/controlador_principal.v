module controlador_principal
(
    input wire b1, b2, clk, 
    output reg[2:0] estado,
    output reg[64:0] fome, felicidade, sono
);

    parameter IDLE = 3'b000, 
              DORMINDO = 3'b001, 
              ACORDANDO = 3'b010,
              COMENDO = 3'b011,
              LIMPANDO_BOCA = 3'b100,
              DANDO_AULA = 3'b101,
              VOLTANDO = 3'b110,
              MORTO = 3'b111;

    reg[2:0] estado_atual, prox_estado;

    // Reset ?

    always @*
    begin
        case (estado_atual)

            IDLE:
            begin
                if (b1 && !b2)
                    prox_estado = COMENDO;
                else if (b2 && !b1)
                    prox_estado = DORMINDO;
                else if (b1 && b2)
                    prox_estado = DANDO_AULA;
            end 
            DORMINDO:
            begin
                if (b2)
                    prox_estado = ACORDANDO;
            end
            ACORDANDO:
            begin
                // Se acabou animação 
                // prox_estado = IDLE
            end
            COMENDO:
            begin
                if (b1)
                    prox_estado = LIMPANDO_BOCA;
            end
            LIMPANDO_BOCA:
            begin
                // Se acabou animação
                // prox_estado = IDLE
            end
            DANDO_AULA:
            begin
                if (b1 && b2)
                    prox_estado = VOLTANDO;
            end
            VOLTANDO:
            begin
                // Se acabou animação
                // prox_estado = IDLE
            end
            MORTO:
            begin
                prox_estado = MORTO;
            end

            default: prox_estado = IDLE;
        endcase
    end

endmodule