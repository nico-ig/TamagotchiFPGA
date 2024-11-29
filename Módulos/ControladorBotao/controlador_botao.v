module controlador_botao
(
    input b_in, clk,
    output reg b_out
);

reg [5:0] counter = 0;

initial b_out = 0;

always @ (posedge clk)
begin
    counter <= !b_in ?
               counter ?
               counter + 6'b1 :
               6'b0 :
               6'b1;

    b_out <= b_in || (counter > 6'b0);
end
endmodule