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

    // Contador para controlar o incremento dos atributos
    parameter CONTADOR_MAX = 19'd66;
    reg [6:0] contador; 

    // Estado inicial
    initial 
    begin
        estado = IDLE;
        fome = 7'd40;
        felicidade = 7'd50;
        sono = 7'd20;
    end

    // Lógica principal
    always @(posedge clk) begin
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

                contador = 19'd0;
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
                            sono = sono + 8'd1;
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
                            fome = fome + 8'd1;
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
                            felicidade = felicidade + 8'd1;
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
