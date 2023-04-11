module ALU(
  input clk,
  input [31:0] a,
  input [31:0] b,
  input [15:0] imm,
  input [5:0] funct,

  output reg [31:0] ot
);

  always @(negedge clk) begin
    case (opcode)
      6'b000000: begin 
        case (funct)
          // arithmetic
          6'b000000: begin  // signed addition
            // if (a[31] == b[31]) ot <= a + b; // same sign
            // else ot <= a-b; // different sign
            ot <= a + b; 
          end

          6'b000001: begin // signed subtraction
            // if (a[31] == b[31]) ot <= a-b; // same sign
            // else ot <= a+b; // different sign
            ot <= a - b;
          end

          6'b000010: ot <= a+b; // unsigned addition
          6'b000011: ot <= a-b; // unsigned subtraction

          // logical
          6'b000100: ot <= a & b; // bitwise AND
          6'b000101: ot <= a | b; // bitwise OR
          6'b000110: ot <= a << b[4:0]; // left shift
          6'b000111: ot <= a >> b[4:0]; // right shift

          // comparison
          6'b001000: ot <= a < b; // less than


          default: ot <= a + b; // unsigned addition by default
        endcase
      end
      // immediate values
      6'b000001: ot <= a + imm; // signed immediate addition
      6'b000010: ot <= a - imm; // unsigned immeidate addition
      6'b000011: ot <= a & {{16{0}, imm}}; // immeidate and 
      6'b000100: ot <= a | {{16{0}, imm}}; // bitwise OR
      6'b000101: ot <= a << imm[4:0]; // left shift
      6'b000110: ot <= a >> imm[4:0]; // right shift
  end
endmodule