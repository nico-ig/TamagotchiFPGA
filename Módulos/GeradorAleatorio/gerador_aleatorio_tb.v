`timescale 1ms / 1ps

module controlador_imagens_tb();

    localparam WIDTH = 3;

    reg clk;
    wire [WIDTH-1:0] data;

    reg [7:0] counters [0: 1 << WIDTH];

    gerador_aleatorio_32 DUT 
    (
        .clk(clk),
        .data(data)
    );

    integer i;

    initial 
    begin
        for (i = 0; i < 1 << WIDTH; i = i + 1) begin
            counters[i] = 0;
        end
        clk = 0;
    end


    always begin
        #5 clk = ~clk;
        counters[data] <= counters[data] + 1;
        if (counters[data] > 100) begin 
            for (i = 0; i < 1 << WIDTH; i = i + 1) begin
                $display("counters[%d]: %d", i, counters[i]);
            end

            $finish();
        end
    end

endmodule
