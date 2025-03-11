
module dff_sync #(parameter Width = 4)(clock,reset,din,dout);
input clock;
input reset;
input [Width+1:0] din;
output [Width+1:0] dout;

reg [Width+1:0] q1;
reg [Width+1:0] q2;
reg [Width+1:0] dout_reg;

always @(posedge clock)
begin
if(reset)	
	dout_reg <= 1'b0;
else 
	q1 <= din;
//	q2 <= q1;
	dout_reg <= q1;
end

assign dout = dout_reg;
endmodule

