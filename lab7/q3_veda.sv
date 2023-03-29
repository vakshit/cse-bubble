module veda(
  input clk,
  input rst,
  input write_enable,
  input [4:0] addr1,
  input [4:0] addr2,
  input [4:0] addr_write,
  input [31:0] datain,
  input mode,
  output [31:0] dataout1,
  output [31:0] dataout2
);

  integer i;
  reg [31:0] cells[31:0]; // first signifies data bits, second is number of such cells
  reg [31:0] out1, out2;
  assign dataout1 = out1;
  assign dataout2 = out2;

  initial begin

    out1 <= 0;
    out2 <= 0;
    for (i = 0; i < 32; i = i + 1)
      cells[i] <= 0;

  end

  always @(posedge clk) begin
    if (rst == 1) begin

      for (i = 0; i < 32; i = i + 1) begin : reset
        cells[i] <= 0;
      end
      
    end else begin
      if (write_enable && mode == 0) begin : scribble

        cells[addr_write] <= datain;
        out1 <= datain1;
        out2 <= datain2;

      end else if (write_enable && mode == 1) begin : interpret

        cells[addr_write] <= datain;
        out1 <= cells[addr1];
        out2 <= cells[addr2];
        
      end else begin

        out1 <= cells[addr1];
        out2 <= cells[addr2];

      end
    end
  end

endmodule