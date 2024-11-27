module controlador_estados
(
    input wire b1, b2, clk, morreu,
    output reg[3:0] estado
);

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0011,
               MORTO = 4'b0100;

    initial
    begin
        estado = IDLE;
    end

    // Lógica principal
    always @(posedge clk) 
    begin

        // Verificação pra ver se morreu
        if (morreu == 1)
            estado <=  MORTO;
        else
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
        end
    end
endmodule
