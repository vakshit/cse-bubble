module veda #(
  parameter SIZE = 32, 
  parameter ADDRESS_WIDTH = 5
  ) (
  input clk,
  input rst,
  input [5:0] opcode,
  input [ADDRESS_WIDTH:0] pc,
  input [ADDRESS_WIDTH:0] addr,
  input [31:0] datain,
  input mode,
  output [31:0] dataout
);

  integer i;
  reg [31:0] cells [SIZE:0]; // first signifies data bits, second is number of such cells
  assign dataout = cells[addr];

  initial begin
    cells[0] = 310;
    cells[1] = 230;
    cells[2] = 30;
    cells[3] = 50;
    cells[4] = 50;
    cells[5] = 60;
    cells[6] = 70;
    cells[7] = 80;
    cells[8] = 90;
    cells[9] = 100;
    for (i = 10; i < (SIZE); i = i + 1)
      cells[i] <= 0;
  end

  always @(posedge clk) begin
    if (rst == 1) begin : reset
      for (i = 0; i < (SIZE); i = i + 1)
        cells[i] <= 0;
    end else if (opcode == 6'b010110) begin : scribble
      cells[addr] = datain;
      // $display("Scribbling %d to cell %d", datain, addr);
      for (i=0;i<10;i=i+1)
        $display("cell[%d] = %d", i, cells[i]);
      $display("----------------------------");
    end 
  end

endmodule
