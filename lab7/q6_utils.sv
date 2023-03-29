module add(
  input [31:0] a,
  input [31:0] b,
  output [31:0] sum
)
  assign sum = a+b;
endmodule

module sub(
  input [31:0] a,
  input [31:0] b,
  output [31:0] diff
)
  assign diff = a-b;
endmodule

