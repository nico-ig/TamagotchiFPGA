module controlador_estados
(
    input wire b1, b2, clk,
    input wire [7:0] fome, felicidade, sono,
    output reg[3:0] estado
);
    // Estados possíveis
    localparam IDLE = 4'b0000, 
               DORMINDO = 4'b0001, 
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100,
               MORTO = 4'b1000;

    reg b1_aux = 0, b2_aux = 0;
    reg [15:0] counter = 1;

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
            estado <= b1_aux && !b2_aux ? COMENDO :
                      !b1_aux && b2_aux ? DORMINDO :
                      b1_aux && b2_aux ? DANDO_AULA : IDLE;
        else
            estado <= b1_aux || b2_aux ? IDLE : estado;

        b1_aux <= counter ? b1_aux : b1;
        b2_aux <= counter ? b2_aux : b2;

        counter <= counter + 16'b1;
    end
endmodule
