module controlador_estados
(
    input wire b1, b2, clk, morreu,
    output reg[3:0] estado
);

    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100,
               MORTO = 4'b1000;

    initial
    begin
        estado = IDLE;
    end

    // Lógica principal
    always @(posedge clk) 
    begin
        case (estado)
            IDLE: estado <= b1 && !b2 ? COMENDO :
                            !b1 && b2 ? DORMINDO :
                            b1 && b2 ? DANDO_AULA : IDLE;
            default: estado <= b1 || b2 ? IDLE : estado;
        endcase
    end
endmodule
