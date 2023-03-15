`timescale 1ps/1ps  
`include "regfile_2.v"
module tb;
    reg [31:0] din;
    reg clk, rst;
    reg [4:0]address_a;
    reg [4:0]address_b;
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
    reg_file_2 rf0(clk, rst, address_a, address_b, mode, write, din, out);
    initial begin
        $monitor($time, " address = %d, out = %d", address_a, out);
        // $dumpfile("dump.vcd");
        // $dumpvars(0, tb);
        address_a <= 12;
        address_b <= 2;
        din <= 123456; #10
        $display("address_a = %d, address_b = %d, data_out = %d", address_a,address_b,out);
        
        address_a <= 15;
        address_b <= 5;
        din <= 12345; #10
        $display("address_a = %d, address_b = %d, data_out = %d", address_a,address_b,out);

        address_a <= 2;
        address_b <= 15;
        din <= 1245; #10
        $display("address_a = %d, address_b = %d, data_out = %d", address_a,address_b,out);

        mode <= 1;
        address_a <= 2;
        address_b <= 12;
        din <= 1312; #10
        $display("address_a = %d, address_b = %d, data_out = %d", address_a,address_b,out);

        mode <= 0;
        address_a <= 15;
        address_b <= 2;
        din <= 10124; #10
        $display("address_a = %d, address_b = %d, data_out = %d", address_a,address_b,out);

        address_a <= 6;
        address_b <= 15;
        din <= 1001; #10
        $display("address_a = %d, address_b = %d, data_out = %d", address_a,address_b,out);

        #100 $finish;
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