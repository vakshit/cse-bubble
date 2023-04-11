module branch #(
  parameter ADDRESS_WIDTH = 6
) (
  input clk,
  input [5:0] opcode,
  input [15:0] imm,
  input [31:0] rs,
  input [31:0] rt,
  input [ADDRESS_WIDTH:0] pc,

  output reg [ADDRESS_WIDTH:0] next_pc,
);
  initial begin 
    ra = pc;
  end

  always @(posedge clk) begin
    case (opcode)
      // conditional branch
      6'b001000: next_pc = ($signed(rs) == $signed(rt)) ? (pc + $signed(imm[15:0])) : pc; // beq
      6'b001001: next_pc = ($signed(rs) != $signed(rt)) ? (pc + $signed(imm[15:0])) : pc; // bne
      6'b001010: next_pc = ($signed(rs) > $signed(rt)) ? (pc + $signed(imm[15:0])) : pc; // bgt
      6'b001011: next_pc = ($signed(rs) >= $signed(rt)) ? (pc + $signed(imm[15:0])) : pc; // bgte
      6'b001100: next_pc = ($signed(rs) < $signed(rt)) ? (pc + $signed(imm[15:0])) : pc; // ble
      6'b001101: next_pc = ($signed(rs) <= $signed(rt)) ? (pc + $signed(imm[15:0])) : pc; // bleq
    endcase
  end
  
endmodule