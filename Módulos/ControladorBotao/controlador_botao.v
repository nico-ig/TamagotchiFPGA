module controlador_botao
(
    input b_in, clk,
    output reg b_out
);

reg [15:0] counter_low = 0, counter_high = 0;

initial b_out = 0;

always @ (posedge clk)
begin
    counter_low <= b_in ? 16'b0 :
                   counter_low ? counter_low + 16'b1 :
                   16'b1;

    counter_high <= b_in || counter_low ? 
                    counter_high + 16'b1 : 
                    16'b0;

    b_out <= (b_in || counter_low) && !counter_high;
end
endmodule
