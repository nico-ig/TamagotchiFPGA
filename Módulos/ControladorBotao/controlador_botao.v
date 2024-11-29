module controlador_botao
(
    input b_in, clk,
    output reg b_out
);

reg b_in_prev;
reg [15:0] debounce_counter; // Timer for debounce logic
localparam DEBOUNCE_THRESHOLD = 16'd20000; // Adjustable threshold based on your clock speed

initial begin
    b_out = 0;
    b_in_prev = 0;
    debounce_counter = 0;
end

always @ (posedge clk) begin
    // Check for rising edge of the button
    if (b_in && !b_in_prev) begin
        // Start debounce counter after edge detection
        debounce_counter <= DEBOUNCE_THRESHOLD;
    end
    else if (debounce_counter != 0) begin
        // Countdown to zero during debounce period
        debounce_counter <= debounce_counter - 1;
    end
    
    // Toggle output if still in pressed state after debounce
    if (debounce_counter == 1) begin
        b_out <= ~b_out;
    end

    // Update previous state of button
    b_in_prev <= b_in;
end
endmodule