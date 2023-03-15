module reg_file(clk, rst, address, mode, write, write_data, out);

    input clk;
    input rst;
    input [4:0] address;
    input write;
    input [31:0] write_data;
    input mode;

    output reg signed [31:0] out;

    reg [31:0] mem[31:0];
    reg [4:0] add_reg;
    integer i;

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
    end

    always @(posedge clk) begin
        add_reg <= address;
    end
    always @(mem[add_reg]) begin
        out = mem[add_reg];
    end
    always @(posedge clk) begin
        if (write && mode == 1'b0) begin
            mem[address] = write_data;
        end
    end
    always @(posedge rst) begin
        mem[address] = 1'b0;
    end

endmodule