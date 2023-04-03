module ALU(
  input clk,
  input [31:0] a,
  input [31:0] b,
  input [5:0] funct,

  output [31:0] result
);

  reg [31:0] ot;

  assign result = ot;

  always @(posedge clk ) begin
    case (funct)
      // arithmetic
      6'b000000: begin  // signed addition
        if (a[31] == b[31]) 
          ot <= a + b; // same sign
        else 
          ot <= a-b; // different sign
      end

      6'b000001: begin // signed subtraction
        if (a[31] == b[31]) ot <= a-b; // same sign
        else ot <= a+b; // different sign
      end

      6'b000010: ot <= a+b; // unsigned addition
      6'b000011: ot <= a-b; // unsigned subtraction

      // logical
      6'b000100: ot <= a & b; // bitwise AND
      6'b000101: ot <= a | b; // bitwise OR
      6'b000110: ot <= a << b; // left shift
      6'b000111: ot <= a >> b; // right shift

      // comparison
      6'b001000: ot <= a < b; // less than

    
      default: ot <= a + b; // unsigned addition by default
    endcase
  end
endmodule