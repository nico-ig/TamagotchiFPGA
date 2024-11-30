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

    reg b1_reg = 0, b2_reg = 0;
    reg [19:0] counter = 20'b0;

    initial
    begin
        estado = IDLE;
    end

    // Lógica principal
    always @(posedge clk) 
    begin
        if (!counter)
        begin
//            if (estado === MORTO || !fome || !sono || !felicidade)
//                estado <= MORTO;
//
//            else 
            if (estado === IDLE)
            begin
                estado <= b1_reg && !b2_reg ? COMENDO :
                          !b1_reg && b2_reg ? DORMINDO :
                          b1_reg && b2_reg ? DANDO_AULA : IDLE;
            end
            else
                estado <= b1_reg || b2_reg ? IDLE : estado;
        end

        b1_reg <= (b1_reg || b1) && counter;
        b2_reg <= (b2_reg || b2) && counter;

        counter <= counter + 20'b1;
    end
endmodule
