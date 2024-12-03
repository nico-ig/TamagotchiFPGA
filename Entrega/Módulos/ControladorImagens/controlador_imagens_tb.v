`timescale 1ms / 1ps

module controlador_imagens_tb();

    reg clk;
    reg [3:0] estado;
    wire [7:0] data_to_send;

    reg [9:0] byte_counter = 0;

    controlador_imagens DUT 
    (
        .clk(clk),
        .estado(estado),
        .data_to_send(data_to_send)
    );

    initial 
    begin
        clk = 0;
    end

    always 
    begin
        estado = 0010;
        #5 clk = ~clk; 
        $display("%d: %02x", byte_counter, data_to_send);
        if (byte_counter == 1023)
            $finish();
        byte_counter = byte_counter + 1;
    end

endmodule
