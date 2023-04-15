`include "cu.sv"

module cu_tb();

  reg clk, reset;
  
  // Instantiate the Unit Under Test (UUT)
  CU uut (
    .clk(clk),
    .rst(reset)
  );


  initial begin
    clk = 0;
    reset = 0;
  end
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, cu_tb);
    # 2000
    $finish;
  end
endmodule