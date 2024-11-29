module controlador_atributos
(
    input wire clk,
    input wire [3:0] estado,
    output reg [7:0] fome, felicidade, sono,
);
    // ESTADOS
    localparam DORMINDO = 4'b0001,
               COMENDO = 4'b0010,
               DANDO_AULA = 4'b0100,
               MORTO = 4'b1000;

    // MAX ATRIBUTOS
    localparam MAX_FOME = 8'd100,
               MAX_SONO = 8'd100,
               MAX_FELICIDADE = 8'd100;

    // Velocidades atributos
    localparam VEL_DESCIDA = 1,
               VEL_SUBIDA = 8'd7;

    // Contador para controlar o incremento dos atributos
    reg [15:0] contador;

    // Estado inicial
    initial 
    begin
        fome = 8'd80;
        felicidade = 8'd70;
        sono = 8'd50;
        contador = 0;
        estado = 0;
    end

    // Lógica principal
    always @(posedge clk) 
    begin       
        contador <= contador + 1;

        if (!contador)
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
                            0;

                    felicidade <= felicidade > VEL_DESCIDA ? 
                                  felicidade - VEL_DESCIDA : 
                                  0;
                end

                COMENDO:
                begin
                    sono <= sono > VEL_DESCIDA ? 
                            sono - VEL_DESCIDA : 
                            0;

                    fome <= fome < MAX_FOME - VEL_SUBIDA ? 
                            fome + VEL_SUBIDA : 
                            MAX_FOME;

                    felicidade <= felicidade > VEL_DESCIDA ? 
                                  felicidade - VEL_DESCIDA : 
                                  0;
                end

                DANDO_AULA:
                begin
                    sono <= sono > VEL_DESCIDA ? 
                            sono - VEL_DESCIDA : 
                            0;

                    fome <= fome > VEL_DESCIDA ? 
                            fome - VEL_DESCIDA : 
                            0;

                    felicidade <= felicidade < MAX_FELICIDADE - VEL_SUBIDA ? 
                                  felicidade + VEL_SUBIDA : 
                                  MAX_FELICIDADE;
                end           

                default:
                begin
                    sono <= sono > VEL_DESCIDA ? 
                            sono - VEL_DESCIDA : 
                            0;

                    fome <= fome > VEL_DESCIDA ? 
                            fome - VEL_DESCIDA : 
                            0;

                    felicidade <= felicidade > VEL_DESCIDA ? 
                                  felicidade - VEL_DESCIDA : 
                                  0;
                end
            endcase
        end
    end
endmodule