module signed_adder(input signed [7:0] a, input signed [7:0] b, output reg signed [7:0] sum);

always @(*) begin
  sum = a + b;
end

endmodule


module top;

reg signed [7:0] a;
reg signed [7:0] b ;
wire signed [7:0] sum;

signed_adder adder(.a(a), .b(b), .sum(sum));

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0, top);
  a = 8'b00000100;
  b = -3;
  #1
  $display("a = %d, b = %d, sum = %d", a, b, sum);
end

endmodule
