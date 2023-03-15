`timescale 1ns/1ps
`include "detector.v"
module tb;
    reg in;
    wire out;
    wire [1:0] st;
    reg clk;
    initial begin
        clk <= 0;
        forever begin
            #5 clk <= ~clk;
        end
    end 
    integer i;
    detector d0(in, out, clk);
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;
        in <= 0; #10
        $display("in = %b, out = %b", in, out);
        in <= 0; #10
        $display("in = %b, out = %b", in, out);
        in <= 1; #10
        $display("in = %b, out = %b", in, out);
        in <= 0; #10
        $display("in = %b, out = %b", in, out);
        in <= 1; #10
        $display("in = %b, out = %b", in, out);
        in <= 0; #10
        $display("in = %b, out = %b", in, out);
        in <= 0; #10
        $display("in = %b, out = %b", in, out);
        in <= 1; #10
        $display("in = %b, out = %b", in, out);
        $finish;
    end
endmodule