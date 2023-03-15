module jk_ff(j,k,clk,q,rst);

input wire j,k,clk,rst;
output reg q=1'b0;
reg [1:0]jk;

always@(negedge clk or posedge rst)
begin
if(rst)begin
    q=1'b0;
  
end
else begin
jk={j,k};
case(jk)
2'b01 : q=1'b0;
2'b10 : q=1'b1;
2'b11 : q= ~q;


endcase
end
end
endmodule

module ripple_counter(m,clk,q);

input m,clk;
output [3:0]q;
wire [2:0] clk1;
reg m_reg,rst=1'b0;

jk_ff f0(1'b1, 1'b1, clk, q[0],rst) ;
assign clk1[0]= (~m_reg & q[0]) | (m_reg & ~q[0]);
jk_ff f1(1'b1,1'b1,clk1[0],q[1],rst);
assign clk1[1]= (~m_reg & q[1]) | (m_reg & ~q[1]);
jk_ff f2(1'b1,1'b1,clk1[1],q[2],rst);
assign clk1[2]= (~m_reg & q[2]) | (m_reg & ~q[2]);
jk_ff f3(1'b1,1'b1,clk1[2],q[3],rst);

always @(negedge clk) begin
    if(m_reg!=m) rst=1'b1;
    else rst=1'b0;
    m_reg = m;
    
end

initial begin
    m_reg = m;
end

endmodule
