`include "q5_inst_decode.sv"
`include "q3_veda.sv"

module ALU(
  input [31:0] instruction,
  input clk, 
  input rst,
  output [31:0] result
);
  // instruction registers
  reg [5:0] opcode;
  reg [4:0] rs;
  reg [4:0] rt;
  reg [4:0] rd;
  reg [4:0] shift;
  reg [5:0] funct;
  reg [15:0] imm;
  reg [25:0] jump;

  // memory registers
  reg [31:0] ALU_result;
  reg [31:0] ALU_src1;
  reg [31:0] ALU_src2;
  reg [31:0] program_counter;
  reg write_enable;

  initial begin
    write_enable = 1'b0;
  end

  inst_decode decode(
    .instruction(instruction),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shift(shift),
    .funct(funct),
    .imm(imm),
    .jump(jump)
  );

  veda src1(
    .clk(clk),
    .rst(rst),
    .write_enable(write_enable),
    .addr1(rs),
    .addr2(rt),
    .addr_write(rd),
    .datain(ALU_result),
    .input (1'b0),
    .dataout1(ALU_src1),
    .dataout2(ALU_src2)
  )



  

  assign result = ALU_result;

  always @(posedge clk) begin
    case (opcode)
    6b'000000:  begin
      case (funct)
        6b'000000: begin

          ALU_result = ALU_src1 + ALU_src2;
        end
        6b'100010: ALU_result = ALU_src1 - ALU_src2;
        6b'100100: ALU_result = ALU_src1 & ALU_src2;
        6b'100101: ALU_result = ALU_src1 | ALU_src2;
        6b'100110: ALU_result = ALU_src1 ^ ALU_src2;
        6b'100111: ALU_result = ~(ALU_src1 | ALU_src2);
        6b'101010: ALU_result = (ALU_src1 < ALU_src2);
        6b'000000: ALU_result = ALU_src2 << shift;
        6b'000010: ALU_result = ALU_src2 >> shift;
        6b'000011: ALU_result = (ALU_src2 >>> shift);
        6b'001000: ALU_result = (ALU_src1 < ALU_src2);
        6b'001010: ALU_result = (ALU_src1 <= ALU_src2);
        6b'001100: ALU_result = (ALU_src1 > ALU_src2);
        6b'001110: ALU_result = (ALU_src1 >= ALU_src2);
        6b'001001: ALU_result = (ALU_src1 != ALU_src2);
        6b'001011: ALU_result = (ALU_src1 == ALU_src2);
        6b'000100: ALU_result = (ALU_src1 << ALU_src2);
        6b'000110: ALU_result = (ALU_src1 >> ALU_src2);
        6b'000111: ALU_result = (ALU_src1 >>> ALU_src2);
        default: ALU_result = 32'b0;
      endcase
    end
    6b'000010: ALU_result = program_counter + 4;
    6b'000100: ALU_result = program_counter + 4;
    6b'000101: ALU_result = program_counter +
  end

endmodule