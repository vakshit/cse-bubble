`timescale 1ps/1ps
`include "sequence_detector.v"

module sequence_detector_tb();

  reg clk, in;
  wire out;
  wire [2:0] curr_state, next_state;

  always #10 clk = ~clk;

  sequence_detector uu0(.clk(clk), .in(in), .out(out));

  initial begin

    $dumpfile("sequence_detector_tb.vcd");
    $dumpvars(0, sequence_detector_tb);

    clk <= 0;
    in <= 0;
  
    // @(posedge clk) in <= 1;
    // @(posedge clk) in <= 1;
    // @(posedge clk) in <= 0;
    // @(posedge clk) in <= 1;
    // @(posedge clk) in <= 0;
    // @(posedge clk) in <= 1;
    // @(posedge clk) in <= 0;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;
    @(posedge clk) in <= 1;
    @(posedge clk) in <= 0;

    #100 $finish;
  end

endmodule