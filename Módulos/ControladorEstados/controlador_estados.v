module controlador_estados
(
    input wire b1, b2, clk,
    input wire [7:0] fome, felicidade, sono,
    output reg[4:0] estado
);
    // Estados possíveis
    localparam INTRO = 5'b00000,
               IDLE = 5'b00001, 
               DORMINDO = 5'b00010, 
               COMENDO = 5'b00100,
               DANDO_AULA = 5'b01000,
               MORTO = 5'b10000;

    reg b1_reg = 0, b2_reg = 0;
    reg [21:0] counter = 22'b0;
    reg [21:0] reset_counter = 22'b1;

    initial
    begin
        estado = INTRO;
    end

    // Lógica principal
    always @(posedge clk) 
    begin
        if (!counter)
        begin
            if (!reset_counter)
                estado <= INTRO;
            else if (estado === MORTO || !fome || !sono || !felicidade)
                estado <= MORTO;

            else if (estado === IDLE)
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

        counter <= counter + 22'b1;
        reset_counter <= (b1_reg && b2_reg) ? reset_counter + 22'b1 :22'b1;
    end
endmodule
