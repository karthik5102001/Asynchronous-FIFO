
module memory #(parameter Width=4,parameter Address=2)(
	input [Width-1 : 0] w_data,
	output reg [Width-1 : 0] r_data,
	input  w_clk,
	input  w_rst,
	input  r_clk,
	input  r_rst,
	input  [Address-1:0] w_addr,
	input  [Address-1:0] r_addr,
	input  w_en,
	input  r_en,
	input full,
	input empty
);

reg [Width-1:0] mem [Address-1:0];

/// Write operation 

always @(posedge w_clk or posedge w_rst)
	begin
		if(w_en == 1'b1 && ~full )
			begin
			mem[w_addr] <= w_data;	
			end
	end

// Read Operation

always @(posedge r_clk or posedge r_rst)
	begin
		if(r_en == 1'b1 && ~empty)
			begin
			 r_data <= mem[r_addr] ;
			end
	end
endmodule

