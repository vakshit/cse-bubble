module veda #(
  parameter SIZE = 32, 
  parameter ADDRESS_WIDTH = 6
  ) (
  input clk,
  input rst,
  input write_enable,
  input [ADDRESS_WIDTH:0] addr,
  input [31:0] datain,
  input mode,
  output [31:0] dataout
);

  integer i;
  reg [31:0] cells [SIZE:0]; // first signifies data bits, second is number of such cells
  reg [31:0] dataout_reg;
  assign dataout = dataout_reg;

  initial begin
    dataout_reg <= 0;
    for (i = 0; i < (SIZE); i = i + 1)
      cells[i] <= 0;
  end

  always @(posedge clk) begin
    if (rst == 1) begin : reset
      for (i = 0; i < (SIZE); i = i + 1)
        cells[i] <= 0;
    end else begin
      if (write_enable && mode == 0) begin : scribble
        cells[addr] <= datain;
        dataout_reg <= datain;
      end else if (write_enable && mode == 1) begin : interpret
        cells[addr] <= datain;
        dataout_reg <= cells[addr];
      end else begin : read
        dataout_reg <= cells[addr];
      end
    end
  end

endmodule
