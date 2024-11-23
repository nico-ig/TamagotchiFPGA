module controlador_atributos
(
    input wire clk,
    input wire [2:0] estado,
    output reg [7:0] fome, felicidade, sono,
    output reg morreu
);

    // MAX ATRIBUTOS
    localparam MAX_FOME = 7'd100,
               MAX_SONO = 7'd100,
               MAX_FELICIDADE = 7'd100;

    // Velocidades atributos
    localparam VEL_DESCIDA = 8'd1,
               VEL_SUBIDA = 8'd7;

    // Contador para controlar o incremento dos atributos
    localparam CONTADOR_MAX = 8'd66;
    reg [7:0] contador, contador_morte; 

    // Estado inicial
    initial 
    begin
        fome = 7'd80;
        felicidade = 7'd70;
        sono = 7'd50;
        contador = 8'd0;
        contador_morte = 8'd0;
        morreu = 0;
    end

    // Lógica principal
    always @(posedge clk) 
    begin

        // Verificação pra ver se morreu
        if (fome <= 10 || sono <= 10 || felicidade <= 10)
            morreu = 1'b1;

        // Decréscimo de atributos
        if (contador_morte < CONTADOR_MAX)
            contador_morte <= contador_morte + 1;
        else    // Contador zerou = Hora de decrementar
        begin

            contador_morte <= 8'd0;

            if (fome > VEL_DESCIDA)
                fome <= fome - VEL_DESCIDA;
            if (sono > VEL_DESCIDA)
                sono <= sono - VEL_DESCIDA;
            if (felicidade > VEL_DESCIDA)
                felicidade <= felicidade - VEL_DESCIDA;
        end

        // Incremento de atributos
        case (estado)
            3'b001: // DORMINDO
            begin
                if (contador < CONTADOR_MAX)
                    contador <= contador + 1;
                else
                begin
                    contador <= 8'd0;
                    if (sono < MAX_SONO)
                        sono <= sono + VEL_SUBIDA;
                end
            end
            3'b010: // COMENDO
            begin
                if (contador < CONTADOR_MAX)
                    contador <= contador + 1;
                else
                begin
                    contador <= 8'd0;
                    if (fome < MAX_FOME)
                        fome <= fome + VEL_SUBIDA;
                end
            end
            3'b011: // DANDO_AULA
            begin
                if (contador < CONTADOR_MAX)
                    contador <= contador + 1;
                else
                begin
                    contador <= 8'd0;
                    if (felicidade < MAX_FELICIDADE)
                        felicidade <= felicidade + VEL_SUBIDA;
                end
            end
        endcase
    end
endmodule