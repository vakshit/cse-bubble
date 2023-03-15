`timescale 1s/1s
`include "ripple_counter.v"
module tb;
   
    reg clk;
    reg m;
    wire [3:0]q;

    ripple_counter uut(m,clk,q);

    always
      #1 clk = ~clk;

    // provide reset values as the input
    initial
       begin
        $dumpfile("ripple_tb.vcd");
        $dumpvars(0,tb);
         clk=0;
         m = 1;
         #4 m = 0;
         #20 m = 1;
         #8 m = 0;
         #12 $finish;
       end
    
endmodule