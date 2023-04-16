// 200091 Akshit Verma 
// 200038 Adit Jain

module branch #(
  parameter ADDRESS_WIDTH = 5
) (
  input clk,
  input [5:0] opcode,
  input [15:0] imm,
  input [31:0] rd,
  input [31:0] rs,
  input [ADDRESS_WIDTH:0] pc,

  output reg [ADDRESS_WIDTH:0] next_pc
);

  always @(*) begin
    case (opcode)
      // conditional branch
      6'b001000: next_pc = ($signed(rd) == $signed(rs)) ? imm[ADDRESS_WIDTH:0] : pc; // beq
      6'b001001: begin
        next_pc = ($signed(rd) != $signed(rs)) ? imm[ADDRESS_WIDTH:0] : pc; // bne
      end
      6'b001010: next_pc = ($signed(rd) > $signed(rs)) ? imm[ADDRESS_WIDTH:0] : pc; // bgt
      6'b001011: next_pc = ($signed(rd) >= $signed(rs)) ? imm[ADDRESS_WIDTH:0] : pc; // bge
      6'b001100: begin
        // $display("signed[rd] = %d", $signed(rd));
        // $display("signed[rs] = %d", $signed(rs));
        // $display("imm = %d", imm[ADDRESS_WIDTH:0]);
        // $display("pc = %d", pc);
        // $display("next_pc = %d", (pc + imm[ADDRESS_WIDTH:0]));
        next_pc = ($signed(rd) < $signed(rs)) ? imm[ADDRESS_WIDTH:0] : pc; // blt
      end
      6'b001101: next_pc = ($signed(rd) <= $signed(rs)) ? imm[ADDRESS_WIDTH:0] : pc; // ble
    endcase
  end
  
endmodule