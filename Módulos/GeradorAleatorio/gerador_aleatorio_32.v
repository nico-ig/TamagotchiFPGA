// https://en.wikipedia.org/wiki/Linear-feedback_shift_register
module gerador_aleatorio_32 (
    input clk,
    output reg [31:0] data
);

wire feedback;

// Feedback calculation using the taps for a 32-bit LFSR
assign feedback = data[31] ^ data[21] ^ data[1] ^ data[0];

initial begin 
    data = 32'h13; // Seed
end

always @(posedge clk) begin
    begin
        data <= {data[30:0], feedback};
    end
end

endmodule
