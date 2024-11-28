module controlador_atributos
(
    input wire clk,
    input wire [3:0] estado,
    output reg [7:0] fome, felicidade, sono,
    output reg morreu
);
    // ESTADOS
    localparam DORMINDO = 4'b0001,
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100;

    // MAX ATRIBUTOS
    localparam MAX_FOME = 7'd100,
               MAX_SONO = 7'd100,
               MAX_FELICIDADE = 7'd100;

    // Velocidades atributos
    localparam VEL_DESCIDA = 8'd1,
               VEL_SUBIDA = 8'd7;

    // Contador para controlar o incremento dos atributos
    reg [7:0] contador;

    // Estado inicial
    initial 
    begin
        fome = 7'd80;
        felicidade = 7'd70;
        sono = 7'd50;
        contador = 8'd0;
        morreu = 1'd0;
    end

    // Lógica principal
    always @(posedge clk) 
    begin       
        contador <= contador + 8'd1;

        if (contador)
        begin
            sono <= sono;
            fome <= fome;
            felicidade <= felicidade;
        end
        else
        begin
            // Incremento/decrementando de atributos
            case(estado)
                DORMINDO:
                begin
                    sono <= sono < MAX_SONO - VEL_SUBIDA ? 
                            sono + VEL_SUBIDA : 
                            MAX_SONO;
                    
                    fome <= fome > VEL_DESCIDA ? 
                        fome - VEL_DESCIDA : 
                        8'd0;

                    felicidade <= felicidade > VEL_DESCIDA ? 
                        felicidade - VEL_DESCIDA : 
                        8'd0;
                end

                COMENDO:
                begin
                    fome <= fome > VEL_DESCIDA ? 
                            fome - VEL_DESCIDA : 
                            8'd0;

                    fome <= fome < MAX_FOME - VEL_SUBIDA ? 
                            fome + VEL_SUBIDA : 
                            MAX_FOME;

                    felicidade <= felicidade > VEL_DESCIDA ? 
                                  felicidade - VEL_DESCIDA : 
                                  8'd0;
                end

                DANDO_AULA:
                begin
                    sono <= sono;
                    fome <= fome;
                    felicidade <= felicidade < MAX_FELICIDADE - VEL_SUBIDA ? 
                                  felicidade + VEL_SUBIDA : 
                                  MAX_FELICIDADE;
                end           
                default:
                begin
                    fome <= fome > VEL_DESCIDA ? 
                        fome - VEL_DESCIDA : 
                        8'd0;

                    sono <= sono > VEL_DESCIDA ? 
                        sono - VEL_DESCIDA : 
                        8'd0;

                    felicidade <= felicidade > VEL_DESCIDA ? 
                            felicidade - VEL_DESCIDA : 
                            8'd0;
                end
            endcase

            // Verificação pra ver se morreu
            morreu <= morreu || fome <= 8'd10 || sono <= 8'd10 || felicidade <= 8'd10;
        end
    end
endmodule