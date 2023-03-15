`timescale 1ps/1ps  
`include "regfile.v"
module tb;
    reg [31:0] din;
    reg clk, rst;
    reg [4:0]address;
    reg mode;
    reg write;

    wire [31:0] out;
    initial begin
        clk <= 0;
        rst <= 0;
        write <= 1;
        mode <= 0;
    end
    always begin
        #5 clk <= ~clk;
    end
    reg_file rf0(clk, rst, address, mode, write, din, out);
    initial begin
        // $dumpfile("dump.vcd");
        // $dumpvars(0, tb);
        // #2
        $monitor($time, " address = %d, out = %d", address, out);
        din = 100;
        address = 5;
        #10
        din = 115;
        address = 6;
        #10
        mode = 1;
        din = 100;
        address = 5;
        #10
        address = 6;
        #10
        mode = 0;
        din = 118;
        address = 31;
        #10

        $finish;
    end
endmodule
/*
module tb;
    reg d, clk, rst, en;
    wire out;
    initial begin
        clk <= 0;
        rst <= 0;
        en <= 1;
    end
    always begin
        #5 clk <= ~clk;
    end
    D_FF dff0(d,clk,rst,en,out);
    initial begin
        #2
        $monitor($time, " d = %b, rst = %b, en = %b, out = %b", d,rst,en,out);
        d <= 1; #10
        d <= 0; #10
        d <= 1; #10
        rst <= 1; #10
        rst <= 0; #10
        d <= 1; #10
        en <= 0; #10
        d <= 1; #10
        d <= 0; #10
        d <= 1; #10
        en <= 1; #10
        d <= 0; #10
        d <= 1; #10
        $finish;
    end
endmodule
*/