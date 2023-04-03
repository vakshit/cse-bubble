`include "veda.sv"
`include "inst_fetch.sv"
`include "inst_decode.sv"
`include "alu.sv"

module CU #(
  parameter ADDRESS_WIDTH = 6,
  parameter INSTRUCTION_SIZE = 32,
  parameter DATA_SIZE = 64
  ) (
  input clk, 
  input rst
);

  reg [31:0] inplace_memory [31:0] ; // 32-bit 32 registers
  reg [ADDRESS_WIDTH:0] pc; // always points the address of the stored instruction, would always be accesed in instruction memory
  reg [31:0] ra_reg; // return address register
  reg [31:0] instruction ; // instruction fetched from instruction memory

  // instruction decode registers
  reg [5:0] opcode;
  reg [4:0] rs;
  reg [4:0] rt;
  reg [4:0] rd;
  reg [4:0] shift;
  reg [5:0] funct;
  reg [15:0] imm;
  reg [25:0] jmp;

  // // instruction memory registers
  // reg inst_write_enable = 1'b1, inst_mode = 1'b0;
  // reg [31:0] inst_datain;

  // storage memory registers
  reg write_enable = 1'b0, mode = 1'b0;
  reg [ADDRESS_WIDTH:0] addr;
  reg [31:0] datain, dataout;

  // ALU registers
  reg [31:0] alu_out, data1, data2;


// declaring modules to be used

  // manages instruction memory

  instruction_fetch insr(
    .clk(clk),
    .rst(rst),
    .pc(pc),
    .instruction(instruction)
  );

  veda memory(
    .clk(clk),
    .rst(rst),
    .write_enable(write_enable),
    .addr(pc),
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
    .a(data1),
    .b(data2),
    .funct(funct),
    .result(alu_out)
  );
  integer i;
  initial begin
    for (i=0 ;i< 32 ;i=i+1)
      inplace_memory[i] <= 0;
    pc = $signed(6'b111111);
    ra_reg = 0;
  end

  // handling reset and clock + instruction fetch
  always @(posedge clk or negedge rst) begin
  if (rst) 
      pc <= 0;
  end

  always @(posedge clk or negedge rst) begin
    if (rst) 
      pc <= 0;
    else begin
      write_enable = 1'b0;
      case (opcode)
        6'b000000: begin // ALU operation R type
          case (funct)
            // arithmetic
            6'b000000: begin  // signed addition
              if (inplace_memory[rs][31] == inplace_memory[rt][31]) 
                inplace_memory[rd] = inplace_memory[rs] + inplace_memory[rt]; // same sign
              else 
                inplace_memory[rd] = inplace_memory[rs] - inplace_memory[rt]; // different sign
            end

            6'b000001: begin // signed subtraction
              if (inplace_memory[rs][31] == inplace_memory[rt][31]) inplace_memory[rd] = inplace_memory[rs] - inplace_memory[rt]; // same sign
              else inplace_memory[rd] = inplace_memory[rs] + inplace_memory[rt]; // different sign
            end

            6'b000010: inplace_memory[rd] = inplace_memory[rs] + inplace_memory[rt]; // unsigned addition
            6'b000011: inplace_memory[rd] = inplace_memory[rs] - inplace_memory[rt]; // unsigned subtraction

            // logical
            6'b000100: inplace_memory[rd] = inplace_memory[rs] & inplace_memory[rt]; // bitwise AND
            6'b000101: inplace_memory[rd] = inplace_memory[rs] | inplace_memory[rt]; // bitwise OR
            6'b000110: inplace_memory[rd] = inplace_memory[rs] <<inplace_memory[rt]; // left shift
            6'b000111: inplace_memory[rd] = inplace_memory[rs] >>inplace_memory[rt]; // right shift

            // comparison
            6'b001000: inplace_memory[rd] = inplace_memory[rs] < inplace_memory[rt]; // less than

          
            default: inplace_memory[rd] = inplace_memory[rs] + inplace_memory[rt]; // unsigned addition by default
          endcase
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached R Type ALU");
        end


        // Conditional branch
        6'b000001: begin // branch on equal I type
          if (inplace_memory[rs] == inplace_memory[rt]) 
            pc = pc + 1 + imm;
          else 
            pc = pc + 1;
            $display("reached branched on equal I type");
        end

        6'b000010: begin // branch on not equal
          if (inplace_memory[rs] != inplace_memory[rt]) 
            pc = pc + 1 + imm;
          else 
            pc = pc + 1;
          $display("reached branch on not equal");
        end

        6'b000011: begin // branch on greater than
          if (inplace_memory[rs] > inplace_memory[rt])
            pc = pc + 1 + imm;
          else
            pc = pc + 1;
            $display("reached branch on greater than");
        end

        6'b000100: begin // branch on greater than or equal
          if (inplace_memory[rs] >= inplace_memory[rt])
            pc = pc + 1 + imm;
          else
            pc = pc + 1;
            $display("reached branch on greater than or equal");
        end

        6'b000101: begin // branch on less than
          if (inplace_memory[rs] < inplace_memory[rt])
            pc = pc + 1 + imm;
          else
            pc = pc + 1;
            $display("reached branch on less than");
        end

        6'b000110: begin // branch on less than or equal
          if (inplace_memory[rs] <= inplace_memory[rt])
            pc = pc + 1 + imm;
          else
            pc = pc + 1;
            $display("reached branch on less than or equal");
        end

        // Unconditional branch
        6'b000111: pc = jmp; // jump J Type 

        6'b001000: pc = inplace_memory[jmp[4:0]]; // jump to register I type

        6'b001001: begin
          ra_reg = pc + 1; // return address in $ra
          pc = jmp; // jump to address
          $display("reached JAL");
        end


        6'b001010: begin
          inplace_memory[rd] = inplace_memory[rs] < inplace_memory[rt] ? 1 : 0;  // slt (set less than)
          pc = pc + 1;
          $display("reached slt (set less than)");
        end

        6'b001011 : begin
          inplace_memory[rd] = inplace_memory[rs] < imm ? 1 : 0;  // slti (set less than)
          pc = pc + 1;
          $display("reached slti (set less than)");
        end

        6'b001100: begin // load word
          write_enable = 1'b0;
          mode = 1'b0;
          addr = inplace_memory[rs] + imm;
          inplace_memory[rt] = dataout;
          pc = pc + 1;
          $display("reached load word");
        end

        6'b001101: begin // store word
          write_enable = 1'b1;
          mode = 1'b0;
          addr = inplace_memory[rs] + imm;
          datain = inplace_memory[rt];
          pc = pc + 1;
          $display("reached store word");
        end

        // ALU operation I type 
        6'b001111: begin // signed addition
          if (inplace_memory[rs][31] == imm[15]) 
            inplace_memory[rt] = inplace_memory[rs] + imm; // same sign
          else 
            inplace_memory[rt] = inplace_memory[rs] - imm; // different sign

          $display("reached I Signed Addition");
          $display("data1: %d, data2: %d, inplace_memory[rd]: %d", inplace_memory[rs], imm, inplace_memory[rt]);
          pc = pc + 1; // regular ALU operation a regular jump
        end

        6'b010000: begin // signed subtraction
          if (inplace_memory[rs][31] == imm[15]) inplace_memory[rt] = inplace_memory[rs] - imm; // same sign
          else inplace_memory[rt] = inplace_memory[rs] + imm; // different sign
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached I Signed Subtraction");
        end

        6'b010001: begin
          inplace_memory[rt] = inplace_memory[rs] + imm; // unsigned addition
          $display("data1: %d, data2: %d, inplace_memory[rd]: %d", inplace_memory[rs], imm, inplace_memory[rt]);
          $display("reached I Unsigned Addition");
          pc = pc + 1; // regular ALU operation a regular jump
        end

        6'b010011: begin
          inplace_memory[rt] = inplace_memory[rs] - imm; // unsigned subtraction
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached I Unsigned Subtraction");
        end

        // logical
        6'b010100: begin 
          inplace_memory[rt] = inplace_memory[rs] & imm; // bitwise AND
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached I bitwise AND");
          end

        6'b010101: begin 
          inplace_memory[rt] = inplace_memory[rs] | imm; // bitwise OR
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached I bitwise OR");
        end

        6'b010110: begin 
          inplace_memory[rt] = inplace_memory[rs] << imm; // left shift
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached I left shift");
          end

        6'b010111: begin 
          inplace_memory[rt] = inplace_memory[rs] >> imm; // right shift
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached I right shift");
          end

        // comparison
        6'b011000: begin 
          inplace_memory[rt] = inplace_memory[rs] < imm; // less than
          pc = pc + 1; // regular ALU operation a regular jump
          $display("reached I less than");
        end

        
        default: begin
          inplace_memory[rt] = inplace_memory[rs] + imm; // unsigned addition by default
          pc = pc + 1; // regular ALU operation a regular jump
          $display("instruction : %d, reached main default", instruction);
        end
        endcase
      end
    end
endmodule
