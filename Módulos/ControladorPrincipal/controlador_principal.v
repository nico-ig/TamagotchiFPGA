module controlador_principal
(
    input wire b1, b2, clk, 
    output reg [2:0] estado,
    output reg [7:0] fome, felicidade, sono    // Atributos
);

    // Estados possíveis
    parameter IDLE = 3'b000, 
              DORMINDO = 3'b001, 
              COMENDO = 3'b010,
              DANDO_AULA = 3'b011,
              MORTO = 3'b100;
    
    // MAX ATRIBUTOS
    parameter MAX_FOME = 7'd100,
              MAX_SONO = 7'd100,
              MAX_FELICIDADE = 7'd100;

    // Velocidades atributos
    parameter VEL_DESCIDA = 8'd1,
              VEL_SUBIDA = 8'd7;

    // Contador para controlar o incremento dos atributos
    parameter CONTADOR_MAX = 19'd66;
    reg [6:0] contador, contador_morte; 

    // Estado inicial
    initial 
    begin
        estado = IDLE;
        fome = 7'd80;
        felicidade = 7'd70;
        sono = 7'd50;
    end

    // Lógica principal
    always @(posedge clk) 
    begin

        // Atributos
        if (contador_morte < CONTADOR_MAX)
                contador_morte = contador_morte + 7'd1;
        else
        begin
            contador_morte = 7'd0;
            
            fome = fome - VEL_DESCIDA;
            sono = sono - VEL_DESCIDA;
            felicidade = felicidade - VEL_DESCIDA;
        end

        // Verificação pra ver se morreu
        if (fome <= 10 || sono <= 10 || felicidade <= 10)
            estado = MORTO;

        // Controle de estados
        case (estado)
            IDLE: 
            begin
                if (b1 && !b2)
                    estado = COMENDO;
                else if (b2 && !b1)
                    estado = DORMINDO;
                else if (b1 && b2)
                    estado = DANDO_AULA;
                else
                    estado = IDLE;

                contador = 7'd0;
            end
            DORMINDO: 
            begin
                if (b2)
                    estado = IDLE;
                else
                begin
                    estado = DORMINDO;

                    if (contador < CONTADOR_MAX)
                        contador = contador + 7'd1;
                    else
                    begin
                        contador = 7'd0;
                        
                        if (sono < MAX_SONO)
                            sono = sono + VEL_SUBIDA;
                    end
                end
            end
            COMENDO: 
            begin
                if (b1)
                    estado = IDLE;
                else
                begin
                    estado = COMENDO;

                    if (contador < CONTADOR_MAX)
                        contador = contador + 7'd1;
                    else
                    begin
                        contador = 7'd0;
                        
                        if (fome < MAX_FOME)
                            fome = fome + VEL_SUBIDA;
                    end
                end
            end
            DANDO_AULA: 
            begin
                if (b1 && b2)
                    estado = IDLE;
                else
                begin
                    estado = DANDO_AULA;

                    if (contador < CONTADOR_MAX)
                        contador = contador + 7'd1;
                    else
                    begin
                        contador = 7'd0;
                        
                        if (felicidade < MAX_FELICIDADE)
                            felicidade = felicidade + VEL_SUBIDA;
                    end
                end
            end
            MORTO: 
            begin
                estado = MORTO;
            end
            default: estado = IDLE;
        endcase
    end

endmodule
