module controlador_estados
(
    input wire b1, b2, clk,
    input wire [7:0] fome, felicidade, sono,
    output wire[3:0] estado
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
        if (estado === MORTO || !fome || !sono || !felicidade)
            estado <= MORTO;
        else if (estado === IDLE)
            estado <= b1 && !b2 ? COMENDO :
                      !b1 && b2 ? DORMINDO :
                      b1 && b2 ? DANDO_AULA : IDLE;
        else
            estado <= b1 || b2 ? IDLE : estado;
    end
endmodule
