module reg_file_2(clk, rst, address_a, address_b, mode, write, write_data, out);

    input clk;
    input rst;
    input [4:0] address_a;
    input [4:0] address_b;
    input write;
    input [31:0] write_data;
    input mode;

    output reg [31:0] out;

    reg [31:0] mem[31:0];
    integer i;

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            mem[i] <= 0;
        end
    end

    always @(posedge clk) begin : read_function
        out <= mem[address_b];
    end
    always @(posedge clk) begin : write_function
        if (rst == 1'b1) begin
            mem[address_a] <= 0;
        end else begin
            if (write && mode == 1'b0) begin
                mem[address_a] <= write_data;
            end            
        end
    end
endmodule