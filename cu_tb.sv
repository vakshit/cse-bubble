// 200091 Akshit Verma 
// 200038 Adit Jain

`include "cu.sv"

module cu_tb();

  reg clk, reset, verbose;
  
  // Instantiate the Unit Under Test (UUT)
  CU uut (
    .clk(clk),
    .rst(reset),
    .verbose(verbose)
  );


  initial begin
    clk = 0;
    reset = 0;
    verbose = 0
  end
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, cu_tb);
    # 10000
    $finish;
  end
endmodule