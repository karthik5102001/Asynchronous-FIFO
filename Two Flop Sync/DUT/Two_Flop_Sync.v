
module dff_sync #(parameter Width = 4)(clock,reset,din,dout);
input clock;
input reset;
input [Width:0] din;
output [Width:0] dout;

reg [Width:0] q1;
reg [Width:0] dout_reg;

always @(posedge clock or negedge reset)
begin
if(reset == 0)	
	dout_reg <= 1'b0;
else 
	q1 <= din;
//	q2 <= q1;
	dout_reg <= q1;
end

assign dout = dout_reg;
endmodule

