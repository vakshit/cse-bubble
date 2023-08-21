// 200091 Akshit Verma 
// 200038 Adit Jain

`include "veda.sv"
`include "inst_fetch.sv"
`include "inst_decode.sv"
`include "alu.sv"
`include "branch.sv"

module CU #(
  parameter ADDRESS_WIDTH = 5,
  parameter INSTRUCTION_SIZE = 32,
  parameter DATA_SIZE = 64
  ) (
  input clk, 
  input verbose,
  input rst
);
  wire [31:0] instruction; // instruction fetched from instruction memory
  reg [ADDRESS_WIDTH:0] pc; // always points the address of the stored instruction, would always be accesed in instruction memory
  wire [ADDRESS_WIDTH:0] next_pc;

  reg [31:0] inplace_memory [31:0] ; // 32-bit 32 registers
  reg [31:0] ra_reg; // return address register

  // instruction decode registers
  wire [5:0] opcode;
  wire [4:0] rs;
  wire [4:0] rt;
  wire [4:0] rd;
  wire [4:0] shift;
  wire [5:0] funct;
  wire [15:0] imm;
  wire [25:0] jmp;

  // storage memory registers
  reg write_enable = 1'b0, mode = 1'b0;
  reg [ADDRESS_WIDTH:0] addr;
  wire [31:0] dataout;
  reg [31:0] datain;

  // ALU registers
  wire [31:0] alu_out;
  // reg [31:0] data1, data2;

  instruction_fetch insr(
    .clk(clk),
    .rst(rst),
    .pc(pc),
    .instruction(instruction)
  );

  veda memory(
    .clk(clk),
    .rst(rst),
    .opcode(opcode),
    .pc(pc),
    .addr(addr),
    .datain(datain),
    .mode(mode),
    .dataout(dataout)
  );

  // decodes instruction and stores to opcode, rs, rt, rd, shift, funct, imm, jmp
  inst_decode decode(
    .instruction(instruction),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shift(shift),
    .funct(funct),
    .imm(imm),
    .jump(jmp)
  );

  // performs ALU operation and stores to result
  ALU alu(
    .clk(clk),
    .opcode(opcode),
    .a(inplace_memory[rs]),
    .b(inplace_memory[rt]),
    .imm(imm),
    .funct(funct),
    .ot(alu_out)
  );

  branch branch(
    .clk(clk),
    .opcode(opcode),
    .imm(imm),
    .rd(inplace_memory[rd]),
    .rs(inplace_memory[rs]),
    .pc(pc),

    .next_pc(next_pc)
  );
  
  integer i;
  initial begin
    for (i=0 ;i< 32 ;i=i+1)
      inplace_memory[i] <= 0;
    pc = 0;
    ra_reg = 0;
  end


  always @(posedge clk) begin
    if (rst) 
      pc <= 0;
    else begin
      if (opcode < 6'b001000) begin : aluOps
        // storing back to register
        inplace_memory[rd] = alu_out;
        if (verbose)
          $display("[%d]. [ALU]: rd = %d, rs = %d, rt = %d, imm = %d", pc+1, inplace_memory[rd], inplace_memory[rs], inplace_memory[rt], imm );
        pc = pc + 1;
      end
      else if (opcode >= 6'b001000 && opcode < 6'b010000) begin : conditionalBranch
        if (verbose)
          $display("[%d]", pc+1);
        pc = next_pc + 1;
        if (verbose)
          $display("[BRANCH]: pc = %d, next_pc = %d", pc, next_pc);
      end
      // Unconditional branch
      else begin
        case (opcode)
          6'b010000: pc = jmp[ADDRESS_WIDTH:0]; // jump to register I type
          6'b010001: pc = inplace_memory[jmp[4:0]]; 
          6'b010010: begin : JAL
          pc = jmp[ADDRESS_WIDTH:0]; // return from subroutine I type
          ra_reg = pc + 1; // return address in $ra
          end

          6'b010011: begin
            inplace_memory[rd] = inplace_memory[rs] < inplace_memory[rt] ? 1 : 0;  // slt (set less than)
            pc = pc + 1;
          end

          6'b010100 : begin
            inplace_memory[rd] = inplace_memory[rs] < imm ? 1 : 0;  // slti (set less than)
            pc = pc + 1;
          end

          6'b010101: begin // load word
            write_enable = 1'b0;
            mode = 1'b0;
            addr = inplace_memory[rs] + imm[ADDRESS_WIDTH:0];
            inplace_memory[rd] = dataout;
            if (verbose)
              $display("[%d]. [LOAD]: dataout = %d, source= %d, dest = %d", pc+1, dataout, addr, rd);
            pc = pc + 1;
          end

          6'b010110: begin // store word
            write_enable = 1'b1;
            mode = 1'b0;
            datain = inplace_memory[rd];
            addr = inplace_memory[rs] + imm[ADDRESS_WIDTH:0];
            pc = pc + 1;
          end
        endcase
      end
    end
  end
endmodule