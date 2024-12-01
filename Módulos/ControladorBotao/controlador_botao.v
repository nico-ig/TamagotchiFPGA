module controlador_botao
(
    input b_in, clk,
    output reg b_out
);

reg dirty = 0;
reg [7:0] counter = 0;

initial b_out = 0;

always @ (posedge clk)
begin
    // O botao esta pressionado e o pulso ainda nao foi gerado
    if (b_in === 0 && b_out === 0 && !dirty)
    begin
        // Botao estavel, gera o pulso e ativa a flag, nao gera outro pulso ate que o botao seja solto
        if (counter === 4'hF)
        begin
            b_out <= 1;
            dirty <= 1;
        end
        counter <= counter + 4'b1;

    // O botao esta solto e um pulso foi gerado
    end else if (b_in === 1 && dirty)
    begin
        // Botao realmente esta solto, desativa a flag e permite que um novo pulso seja gerado
        if (counter === 4'hF)
            dirty <= 0;
        counter <= counter + 4'b1;

    end else 
        b_out <= 0;
end
endmodule
