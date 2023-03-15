module sequence_detector(input clk, input in, output out);
  parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

  reg out;
  reg [1:0] curr_state = S0, next_state = S0;

  always @(posedge clk) begin
    curr_state <= next_state;
  end

  always @(curr_state or in) begin
    case(curr_state)
      S0 : begin
        if(in) next_state = S1;
        else next_state = S0;

        out = 1'b0;
      end

      S1 : begin
        if(!in) next_state = S2;
        else next_state = S1;

        out = 1'b0;
      end

      S2 : begin
        if(in) next_state = S3;
        else next_state = S0;

        out = 1'b0;
      end

      S3 : begin
        if(!in) begin
          next_state = S2;
          out = 1'b1;
        end
        else begin
          next_state = S1;
          out = 1'b0;
        end
      end
    endcase
  end

endmodule