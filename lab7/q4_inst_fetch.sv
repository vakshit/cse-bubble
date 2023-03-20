module instruction_fetch(
  input clk,
  input rst,
  input [31:0] pc_in,
  input [31:0] instr_mem [0:IM_SIZE-1],
  output reg [31:0] ir_out,
  output reg [31:0] pc_out
);

  parameter IM_SIZE = 1024; // size of the instruction memory
  parameter INSTR_SIZE = 32; // size of each instruction

  reg [31:0] pc_reg; // register to hold the PC value

  // initialize the PC register
  always @(posedge rst) begin
    pc_reg <= 0;
  end

  // update the PC value at each clock cycle
  always @(posedge clk) begin
    if (rst)
      pc_reg <= 0;
    else 
      pc_reg <= pc_out;
  end

  // fetch the instruction from the instruction memory
  always @(posedge clk) begin
    if (rst)
      ir_out <= 0;
    else 
      ir_out <= instr_mem[pc_reg / INSTR_SIZE];
  end

  // update the PC to the next instruction address
  always @(posedge clk) begin
    if (rst)
      pc_out <= 0;
    else 
      pc_out <= pc_reg + INSTR_SIZE;
  end

endmodule