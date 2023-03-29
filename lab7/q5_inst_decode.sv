`timescale 1ns / 1ps
// module inst_decode (
//   input [31:0] instruction,
//   output [5:0] opcode,
//   output [4:0] rs,
//   output [4:0] rt,
//   output [4:0] rd,
//   output [4:0] shift,
//   output [5:0] funct,
//   output [15:0] imm,
//   output [25:0] jump,
//   output [2:0] alu_control
// );
//   reg [2:0] alu_reg = 3'b000;

//   // General
//   assign opcode = instruction[31:26];
//   assign rs = instruction[25:21];
//   assign rt = instruction[20:16];
  
//   // R type
//   assign rd = instruction[15:11];
//   assign shift = instruction[10:6];
//   assign funct = instruction[5:0];
  
//   // I Type
//   assign imm = instruction[15:0];
  
//   // J type
//   assign jump = instruction[25:0];
  

  
//   assign alu_control = alu_reg;

//   always @(*) begin
//     case (opcode)
//       6'b000000: begin // R-type instruction
//         case (funct)
//           6'b100000: alu_reg = 3'b000; // add
//           6'b100010: alu_reg = 3'b001; // subtract
//           6'b100100: alu_reg = 3'b100; // and
//           6'b100101: alu_reg = 3'b101; // or
//           6'b000000: alu_reg = 3'b010; // shift left logical
//           6'b000010: alu_reg = 3'b011; // shift right logical
//           6'b101010: alu_reg = 3'b111; // slt
//           default: alu_reg = 3'b000; // default to add
//         endcase
//       end
//       6'b001000: alu_reg = 3'b000; // addi
//       6'b001001: alu_reg = 3'b001; // addiu
//       6'b001100: alu_reg = 3'b100; // andi
//       6'b001101: alu_reg = 3'b101; // ori
//       6'b100011: alu_reg = 3'b000; // lw
//       6'b101011: alu_reg = 3'b000; // sw
//       6'b000100: alu_reg = 3'b010; // beq
//       6'b000101: alu_reg = 3'b011; // bne
//       6'b000111: alu_reg = 3'b111; // bgt
//       6'b001011: alu_reg = 3'b101; // slti
//       default: alu_reg = 3'b000; // default to add
//     endcase
//   end

// endmodule


// instructions would be such that opcode is sequential
module inst_decode (
  input [31:0] instruction,
  output [5:0] opcode,
  output [4:0] rs,
  output [4:0] rt,
  output [4:0] rd,
  output [4:0] shift,
  output [5:0] funct,
  output [15:0] imm,
  output [25:0] jump
);
  // General
  assign opcode = instruction[31:26];
  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  
  // R type
  assign rd = instruction[15:11];
  assign shift = instruction[10:6];
  assign funct = instruction[5:0];
  
  // I Type
  assign imm = instruction[15:0];
  
  // J type
  assign jump = instruction[25:0];

endmodule


module testbench_instruction_decode;
    // Define the inputs and expected outputs
    reg [31:0] instr;
    wire [5:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shift;
    wire [5:0] funct;
    wire [15:0] imm;
    wire [25:0] jump;
    
     // Instantiate the module to be tested
    inst_decode ID_inst (instr, opcode, rs, rt, rd, shift, funct, imm, jump);

    // Provide stimulus to the inputs
    initial begin
        instr = 32'h8c080000;  // load word instruction
        #10;
        instr = 32'h012a5820;  // add instruction
        #10;
        instr = 32'h212A5802;  // addi instruction
        #10;
        instr = 32'h10000005;  // beq instruction
        #10;
       
        $finish;
    end

    // Monitor the outputs
    always @(opcode or rs or rt or rd or shift or funct or imm or jump ) begin
        $display("opcode = %d, rs = %d, rt = %d, rd = %d, shift = %d, funct = %d, imm = %d, jump = %d", opcode, rs, rt, rd, shift, funct, imm, jump);
    end

endmodule
