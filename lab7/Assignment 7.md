# Intro

Based on this, we can design the op-code formats for the instructions and develop the necessary Verilog modules for the processor. Here's my proposed op-code format for the processor:

| 31 -26 | 25-21 | 20-16 | 15-11 | 10-6  | 5-0 |
| ------ | ----- | ----- | ----- | ----- | --- |
| op     | rs    | rt    | rd    | funct | imm |

In this format, `op` is a 6-bit opcode, `rs`, `rt`, and `rd` are 5-bit register specifiers, `funct` is a 6-bit function code, and `imm` is a 16-bit immediate value. This format supports all the instructions in Table 1.

Based on this op-code format, we can develop the necessary Verilog modules for the CSE-BUBBLE processor. Here are the modules that we will need:

- Instruction Fetch (IF) module: This module is responsible for fetching instructions from the instruction memory and storing them in an instruction register.

- Instruction Decode (ID) module: This module is responsible for decoding the instruction register and generating the control signals that will be used by the other modules in the processor.

- Register File (RF) module: This module is responsible for reading from and writing to the register file. It will have two read ports and one write port.

- ALU module: This module is responsible for performing arithmetic and logical operations. It will also have a shifter for the shift instructions.

- Data Memory (DM) module: This module is responsible for reading from and writing to the data memory.

- Program Counter (PC) module: This module is responsible for keeping track of the address of the next instruction.

- Control module: This module is responsible for generating the control signals that will be used by the other modules in the processor.

We will also need a finite state machine to control the flow of instructions and data through the processor. The state machine will have the following states:

- IF: Instruction Fetch
- ID: Instruction Decode
- EX: Execute
- DM: Data Memory
- WB: Write Back
  During each clock cycle, the processor will be in one of these states, and the appropriate modules will be activated to perform the necessary operations. The state machine will be controlled by the control module, which will generate the necessary control signals for each state.

# Q1

As CSE-BUBBLE has a total of 32 registers. Following are the registers and their usage protocol:

- Registers $r_0 - r_{31}$: These are general-purpose registers and can be used for storing intermediate results or values that are required by the instructions during execution. Among these, the following have special roles:

  - $r_{0}$: This register always holds the value 0. Writing to this register has no effect.
  - $r_{29} - r_{31}$: These registers are reserved for use by the operating system.

- $PC$: This is the program counter register and it holds the address of the next instruction to be executed.

- $HI$ and $LO$: These are special-purpose registers used for storing the results of certain arithmetic and multiplication instructions. Specifically, $HI$ is used to store the high-order 32 bits of a 64-bit result, while $LO$ is used to store the low-order 32 bits of a 64-bit result.

- $r_a$: This is the return address register and is used to store the address of the instruction that follows a jal (jump and link) instruction.

The usage protocol for the registers is as follows:

- The general-purpose registers can be used by any instruction for any purpose.
- $PC$, $HI$, $LO$, and $ra$ registers are used only by certain instructions as specified in Table 1.
- $r_0$ always holds the value 0 and cannot be written to.
- Registers $r_{29} - r_{31}$ are reserved for use by the operating system and should not be used by application programs.

# Q2

The size of the instruction and data memory in VEDA should be determined based on the maximum number of instructions and data that need to be stored in the memory.

Assuming that we have 32-bit instructions and 32-bit data, we can calculate the size of the memory as follows:

- Instruction memory size: If we have n instructions, the instruction memory size will be n x 4 bytes (since each instruction is 4 bytes long).
- Data memory size: If we have m data values to store, the data memory size will be m x 4 bytes (since each data value is 4 bytes long).
  The actual values of n and m will depend on the specific requirements of the application and the program being executed on the processor. Therefore, these values need to be decided before determining the size of the memory.

# Q3

The instruction set for CSE-BUBBLE includes three types of instructions: R-type, I-type, and J-type instructions. The encoding methodology for each type of instruction is as follows:

### R-Type Instructions:

R-type instructions use three register operands and an operation code. The layout of the R-type instruction is as follows:

| 6-bit Opcode | 5-bit rs | 5-bit rt | 5-bit rd | 5-bit shift amount | 6-bit funct |
| ------------ | -------- | -------- | -------- | ------------------ | ----------- |
| Opcode       | rs       | rt       | rd       | Shift Amount       | funct       |
| 6 bits       | 5 bits   | 5 bits   | 5 bits   | 5 bits             | 6 bits      |

The fields in the R-type instruction layout are defined as follows:

- Opcode: a 6-bit operation code that specifies the type of R-type instruction.
- rs: a 5-bit field that specifies the source register.
- rt: a 5-bit field that specifies the second source register.
- rd: a 5-bit field that specifies the destination register.
- Shift amount: a 5-bit field that specifies the number of bits to shift the value in the rt register (only used in shift instructions).
- Funct: a 6-bit function code that specifies the specific operation to be performed.
  The encoding methodology for R-type instructions is as follows:

| 6-bit Opcode | 5-bit rs | 5-bit rt | 5-bit rd | 5-bit shift amount | 6-bit funct  |
| ------------ | -------- | -------- | -------- | ------------------ | ------------ |
| 000000       | Opcode   | rs       | rt       | rd                 | Shift amount |

### I-Type Instructions:

I-type instructions use two register operands and an immediate value. The layout of the I-type instruction is as follows:

| 6-bit Opcode | 5-bit rs | 5-bit rt | 16-bit immediate value |
| ------------ | -------- | -------- | ---------------------- |
| Opcode       | rs       | rt       | Immediate Value        |
| 6 bits       | 5 bits   | 5 bits   | 16 bits                |

The fields in the I-type instruction layout are defined as follows:

- Opcode: a 6-bit operation code that specifies the type of I-type instruction.
- rs: a 5-bit field that specifies the source register.
- rt: a 5-bit field that specifies the destination register.
- Immediate value: a 16-bit field that specifies the immediate value.
  The encoding methodology for I-type instructions is as follows:

| 6-bit Opcode | 5-bit rs | 5-bit rt | 16-bit immediate value |
| ------------ | -------- | -------- | ---------------------- |
| Opcode       | rs       | rt       | Immediate Value        |

### J-Type Instructions:

J-type instructions use a 26-bit jump target address. The layout of the J-type instruction is as follows:

| 6-bit Opcode | 26-bit jump target address |
| ------------ | -------------------------- |
| Opcode       | Jump Target Address        |
| 6 bits       | 26 bits                    |

The fields in the J-type instruction layout are defined as follows:

J-type instruction encoding:

- opcode (6 bits): specifies the operation type, for example, 000010 for jump
- jump address (26 bits): specifies the address to jump to

# Q4

To implement the instruction fetch phase, we need to perform the following steps:

Get the value of the program counter (PC) from the PC register.
Access the instruction memory using the PC value and retrieve the instruction at that address.
Increment the PC by the size of the instruction (32 bits).
Store the retrieved instruction in the instruction register.
Here's how we can implement the instruction fetch phase in Verilog:

```verilog
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
```

```bash
# need to use -g2012 to enable the 32-bit indexing
$ iverilog -g2012 -o instruction_fetch instruction_fetch.sv
```

In this Verilog module, we have an input for the program counter (pc_in) and an input for the instruction memory (instr_mem). We also have an output for the instruction register (ir_out) and an output for the updated program counter (pc_out).

The module has three internal registers: pc_reg, which holds the current value of the program counter; ir_out, which holds the fetched instruction; and pc_out, which holds the updated program counter value.

The module uses three always blocks to implement the instruction fetch phase. The first always block initializes the pc_reg register to zero on reset.

The second always block updates the pc_reg register to the value of pc_out at each clock cycle, except when there is a reset (rst).

The third always block implements the instruction fetch phase by accessing the instruction memory using the value of pc_reg and storing the fetched instruction in ir_out. It also updates the value of pc_out to the next instruction address.

Note that we assume that the instruction memory is word-addressable and each instruction occupies a single word. The INSTR_SIZE parameter is set to 32 bits to reflect this assumption. Also, we assume that the instruction memory is implemented as an array of 32-bit words (instr_mem [0:IM_SIZE-1]).

# Q5

Here is a possible implementation for the instruction decode module based on the opcode of the instruction:

```verilog
module instruction_decode (
  input [31:0] instruction,
  output [4:0] rs,
  output [4:0] rt,
  output [4:0] rd,
  output [4:0] imm,
  output [5:0] opcode,
  output [5:0] funct,
  output [2:0] alu_control
);
  reg [2:0] alu_reg = 3'b000;;

  assign opcode = instruction[31:26];
  assign funct = instruction[5:0];

  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  assign rd = instruction[15:11];

  assign imm = instruction[15:0];
  assign alu_control = alu_reg;

  always @(*) begin
    case (opcode)
      6'b000000: begin // R-type instruction
        case (funct)
          6'b100000: alu_reg = 3'b000; // add
          6'b100010: alu_reg = 3'b001; // subtract
          6'b100100: alu_reg = 3'b100; // and
          6'b100101: alu_reg = 3'b101; // or
          6'b000000: alu_reg = 3'b010; // shift left logical
          6'b000010: alu_reg = 3'b011; // shift right logical
          6'b101010: alu_reg = 3'b111; // slt
          default: alu_reg = 3'b000; // default to add
        endcase
      end
      6'b001000: alu_reg = 3'b000; // addi
      6'b001001: alu_reg = 3'b001; // addiu
      6'b001100: alu_reg = 3'b100; // andi
      6'b001101: alu_reg = 3'b101; // ori
      6'b100011: alu_reg = 3'b000; // lw
      6'b101011: alu_reg = 3'b000; // sw
      6'b000100: alu_reg = 3'b010; // beq
      6'b000101: alu_reg = 3'b011; // bne
      6'b000111: alu_reg = 3'b111; // bgt
      6'b001011: alu_reg = 3'b101; // slti
      default: alu_reg = 3'b000; // default to add
    endcase
  end

endmodule
```

The module takes in a 32-bit instruction and outputs various fields such as the opcode, function code, and register/constant values needed for execution. The alu_control output indicates which ALU operation to perform based on the opcode and function code, or whether to perform a memory operation or a branch instruction.

# Testbench

To write a testbench for the above module, we can follow the steps below:

- Instantiate the module to be tested.
- Define the inputs and expected outputs.
- Provide stimulus to the inputs.
- Monitor the outputs.
- Compare the actual outputs with the expected outputs and flag any discrepancies.

Here is an example testbench for the instruction decode module:

```verilog
`timescale 1ns/1ns

module testbench_instruction_decode;

    // Instantiate the module to be tested
    instruction_decode ID_inst ();

    // Define the inputs and expected outputs
    reg [31:0] instr;
    wire [3:0] opcode;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [5:0] shamt;
    wire [5:0] funct;

    // Provide stimulus to the inputs
    initial begin
        instr = 32'h8c080000;  // load word instruction
        #10;
        instr = 32'h012a5820;  // add instruction
        #10;
        instr = 32'h012a5802;  // addi instruction
        #10;
        instr = 32'h10000005;  // beq instruction
        #10;
        instr = 32'h08000005;  // j instruction
        #10;
        instr = 32'h00000008;  // jr instruction
        #10;
        instr = 32'h0c100000;  // jal instruction
        #10;
        instr = 32'h00000000;  // nop instruction
        #10;
        instr = 32'h00000000;  // nop instruction
        #10;
        instr = 32'h00000000;  // nop instruction
        #10;
        $finish;
    end

    // Monitor the outputs
    always @(opcode or rs or rt or rd or shamt or funct) begin
        $display("opcode = %d, rs = %d, rt = %d, rd = %d, shamt = %d, funct = %d", opcode, rs, rt, rd, shamt, funct);
    end

    // Connect the inputs and outputs
    assign ID_inst.instr = instr;
    assign opcode = ID_inst.opcode;
    assign rs = ID_inst.rs;
    assign rt = ID_inst.rt;
    assign rd = ID_inst.rd;
    assign shamt = ID_inst.shamt;
    assign funct = ID_inst.funct;

endmodule
```

In this testbench, we have instantiated the instruction_decode module and provided it with a series of input instructions. We have then monitored the outputs opcode, rs, rt, rd, shamt, and funct and printed their values to the console using $display statements.

Note that the above testbench is just an example and may need to be modified depending on the specific implementation of the instruction_decode module.
