module controlador_estados
(
    input wire b1, b2, clk, morreu,
    output reg[2:0] estado
);

    // Estados possíveis
    localparam IDLE = 3'b000, 
               DORMINDO = 3'b001, 
               COMENDO = 3'b010,
               DANDO_AULA = 3'b011,
               MORTO = 3'b100;

    initial
    begin
        estado = IDLE;
    end

    // Lógica principal
    always @(posedge clk) 
    begin

        // Controle de estados
        case (estado)
            IDLE: 
            begin
                if (b1 && !b2)
                    estado <= COMENDO;
                else if (b2 && !b1)
                    estado <= DORMINDO;
                else if (b1 && b2)
                    estado <= DANDO_AULA;
                else
                    estado <= IDLE;
            end
            DORMINDO: 
            begin
                if (b2)
                    estado <= IDLE;
                else
                    estado <= DORMINDO;
                    
            end
            COMENDO: 
            begin
                if (b1)
                    estado <= IDLE;
                else
                    estado <= COMENDO;
            end
            DANDO_AULA: 
            begin
                if (b1 && b2)
                    estado <= IDLE;
                else
                    estado <= DANDO_AULA;
            end
            MORTO: 
            begin
                estado <= MORTO;
            end
            default: estado <= IDLE;
        endcase

        // Verificação pra ver se morreu
        if (morreu == 1)
            estado <= MORTO;
    end

endmodule
