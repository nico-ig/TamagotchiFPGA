module controlador_botao
(
    input b_in, clk,
    output reg b_out
);

reg [15:0] counter = 0;

initial b_out = 0;

always @ (posedge clk)
begin
    counter <= !b_in ?
               counter ?
               counter + 16'b1 :
               16'b0 :
               16'b1;

    b_out <= b_in || (counter > 16'b0);
end
endmodule