

module ALU(
  input [31:0] a,
  input [31:0] b,
  input [4:0] funct,

  output [31:0] out,
);

  reg [31:0] ot;

  assign out = ot;

  case (funct)
    // arithmetic
    5'b00000: begin  // signed addition
      if (a[31] == b[31]) ot = a+b; // same sign
      else ot = a-b;m // different sign
    end

    5'b00001: begin // signed subtraction
      if (a[31] == b[31]) ot = a-b; // same sign
      else ot = a+b; // different sign
    end

    5'b00010: ot = a+b; // unsigned addition
    5'b00011: ot = a-b; // unsigned subtraction

    // logical
    5'b00100: ot = a & b; // bitwise AND
    5'b00101: ot = a | b; // bitwise OR
    5'b00110: ot = a << b; // left shift
    5'b00111: ot = a >> b; // right shift

    // comparison
    5'b01000: ot = a < b; // less than

  
    default: ot = a + b // unsigned addition by default
  endcase
endmodule