module detector(in, out, clk);
    input in, clk;
    output reg out;
    reg [1:0] stt;
    reg [1:0] ns;
    initial begin
        stt <= 2'b00;
    end
    always @(stt or in) begin : combi
        ns[0] <= in;
        ns[1] <= (stt[0] & ~stt[1] & ~in) | (~stt[0] & stt[1] & in) | (stt[0] & stt[1] & ~in);
    end
    always @(posedge clk)begin : sequence
        stt <= ns;
    end
    always @(clk) begin : opt
        out <= stt[0] & stt[1] & ~in;
    end
endmodule