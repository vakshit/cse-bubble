`include "q5_inst_decode.sv"

module CU(
  input clk, 
  input rst,
  input [31:0] r0,
  input [31:0] r1,
  input [31:0] jump,
  input [31:0] instruction,
  input [31:0] pc_in,
  output [31:0] ra,
  output [31:0] pc_out
);

  reg [31:0] pc;
  reg [31:0] ra_reg;

  // instruction registers
  reg [5:0] opcode;
  reg [4:0] rs;
  reg [4:0] rt;
  reg [4:0] rd;
  reg [4:0] shift;
  reg [5:0] funct;
  reg [15:0] imm;
  reg [25:0] jmp;

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

  assign ra = ra_reg;
  assign pc_out = pc;
  // pc = pc_in;
  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      pc <= 0;
    end else begin
      
      case (opcode)
        6'b000000: pc = pc_in + 1; // regular ALU operation a regular jump
        6'b000001: begin // branch on equal
          if (r0==r1) begin
            pc = pc_in + 1;
            pc = pc + jump;
          end else begin
            pc = pc_in + 1;
          end
        end

        6'b000010: begin // branch on not equal
          if (r0==r1) begin
            pc = pc_in + 1;
          end else begin
            pc = pc_in + 1 + jump;
          end
        end

        6'b000011: begin // branch on greater than
          if (r0 > r1) begin
            pc = pc_in + 1 + jump;
          end else begin
            pc = pc_in + 1;
          end
        end

        6'b000100: begin // branch on greater than or equal
          if (r0 >= r1) begin
            pc = pc_in + 1 + jump;
          end else begin
            pc = pc_in + 1;
          end
        end

        6'b000101: begin // branch on less than
          if (r0 < r1) begin
            pc = pc_in + 1 + jump;
          end else begin
            pc = pc_in + 1;
          end
        end

        6'b000110: begin // branch on less than or equal
          if (r0 <= r1) begin
            pc = pc_in + 1 + jump;
          end else begin
            pc = pc_in + 1;
          end
        end

        6'b000111: pc = jump; // jump

        6'b001000: pc = r0; // branch on equal to immediate

        6'b001001: begin
          ra_reg = pc_in +1; // return address in $ra
          pc = r0; // jump to address
        end
        // default: 
      endcase

    end
  end


  assign pc_out = pc;

endmodule


module CU_tb();
  reg clk; 
  reg rst;
  reg [31:0] r0;
  reg [31:0] r1;
  reg [31:0] jump;
  reg [31:0] instruction;
  reg [31:0] pc_in;
  wire [31:0] ra;
  wire [31:0] pc_out;

  CU cu(
    .clk(clk), 
    .rst(rst),
    .r0(r0),
    .r1(r1),
    .jump(jump),
    .instruction(instruction),
    .pc_in(pc_in),
    .ra(ra),
    .pc_out(pc_out)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, CU_tb);
    clk = 0;
    rst = 1;
    r0 = 0;
    r1 = 0;
    jump = 0;
    instruction = 0;
    pc_in = 0;
    #5 

    r0 = 10;
    r1 = 10;
    jump = 20;
    instruction = 32'b00000100000000001111111101010101;
    // pc_in = pc_out;
    #5

    r0 = 10;
    r1 = 10;
    jump = 20;
    instruction = 32'b00001000000000001111111101010101;
    #5

    r0 = 20;
    r1 = 10;
    jump = 20;
    instruction = 32'b00001100000000001111111101010101;
    #5

    r0 = 10;
    r1 = 20;
    jump = 20;
    instruction = 32'b00010000000000001111111101010101;
    #5

    r0 = 10;
    r1 = 10;
    jump = 20;
    instruction = 32'b00010100000000001111111101010101;
    #5

    r0 = 10;
    r1 = 10;
    jump = 20;
    instruction = 32'b00011000000000001111111101010101;

    $finish;
  end
endmodule




