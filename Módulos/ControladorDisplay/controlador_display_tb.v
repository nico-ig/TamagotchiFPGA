`timescale 1ns/1ns

module test();
  reg clk = 0;
  reg [1:0] should_end = 0;
  reg [7:0] image[1024:0];
  reg [7:0] data_to_send;
  reg [2:0] page = 0, previous_state = 0;
  reg [6:0] column = 127;
  wire io_sclk, io_sdin, io_dc, io_reset, io_cs;

  controlador_display #(11'b10) DUT (
      .clk(clk),
      .data_to_send(data_to_send),
      .io_sclk(io_sclk),
      .io_sdin(io_sdin),
      .io_cs(io_cs),
      .io_dc(io_dc),
      .io_reset(io_reset)
  );

  initial
  begin
    $readmemh("image.hex", image, 0, 1023);
    $dumpfile("controlador_display.vcd");
    $dumpvars(0,test);
  end

  always
    #1 clk = ~clk;

  always @ (posedge clk)
  begin
    previous_state <= DUT.state;
    if (previous_state == 4)
    begin
      if (page == 0)
      begin
        $display();
        if (column == 127)
        begin
          if (should_end == 2)
            $finish();
          should_end <= 1 << should_end;
          $display("\n            |    P0    |    P1    |    P2    |    P3    |    P4    |    P5    |    P6    |    P7");
        end

        $write("column: %03d", column == 127 ? 0 : column + 1);
        column <= column + 1;
      end

      $write(" | %b", DUT.dataToSend);
      page <= page + 1;
    end
  end

endmodule
