// 200091 Akshit Verma 
// 200038 Adit Jain

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
  assign rd = instruction[25:21];
  assign rs = instruction[20:16];
  
  // R type
  assign rt = instruction[15:11];
  assign shift = instruction[10:6];
  assign funct = instruction[5:0];
  
  // I Type
  assign imm = instruction[15:0];
  
  // J type
  assign jump = instruction[25:0];

endmodule