module instruction_fetch #(
  parameter SIZE = 32, // size of the instruction memory
  parameter INSTR_SIZE = 32, // size of each instruction
  parameter ADDRESS_WIDTH = 6 // width of the address bus
)(
  input clk,
  input rst,
  input [ADDRESS_WIDTH:0] pc,
  output [31:0] instruction
);

  // VEDA memory
  // fetches instruction at addr pc and stores to instruction
  reg [31:0] cells [SIZE:0]; // first signifies data bits, second is number of such cells
  reg [31:0] dataout_reg;
  assign instruction = dataout_reg;

  // to store data in memory
  integer file;
  integer i;
  reg [7:0] byte0, byte1, byte2, byte3;

  initial begin
    // file = $fopen("input.txt", "r");  // open file for reading
    // if (file == 0) begin
    //   $display("Error: could not open input file");
    //   $finish;
    // end
    // // read file into array
    // i = 0;
    // while (!$feof(file) && (i < 2)) begin
    //   $fread(byte3, file);
    //   $fread(byte2, file);
    //   $fread(byte1, file);
    //   $fread(byte0, file);
    //   cells[i] = (byte3 << 24) | (byte2 << 16) | (byte1 << 8) | byte0;
    //   i = i + 1;
    // end
    
    // $fclose(file);  // close file

    $readmemb("input.txt", cells);
    
    // display array contents
    for (i = 0; i < 10; i = i + 1) begin
      $display("cells[%d] = %d", i, cells[i]);
    end
  end

  always @(posedge clk) begin
    if (rst == 1) begin : reset
      for (i = 0; i < (SIZE); i = i + 1)
        cells[i] <= 0;
    end 
    else begin : normal
      dataout_reg <= cells[pc];
    end
  end


endmodule