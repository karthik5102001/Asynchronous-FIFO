module read_ptr_empty_logic #(parameter address=2) (rclk,r_rst,r_en,write_ptr,read_ptr,empty);

	input rclk,r_rst,r_en;
	input [address:0] write_ptr;
	output [address:0] read_ptr;
	output empty;

	reg [address:0] count;
	wire [address:0] read_pointer;
	reg empty_logic;

always @(posedge rclk or posedge r_rst)
begin
  //  read_pointer = count;
	if(r_rst == 1'b1)
	begin
		empty_logic <= 1'b1;
	end
	else if(r_en == 1'b1 || r_rst == 1'b0)
	       begin 
				if(write_ptr[address:0] == read_pointer[address:0])
				begin
					empty_logic = 1'b1;
				end
				else
				begin
					empty_logic = 1'b0;
				end
			end
	 else begin
			         empty_logic = 1'b0;
		  end
end

always @(posedge r_en or posedge r_rst)
begin
if(r_rst == 1'b1)
	begin
		count <= 0;
	end
	else if(empty_logic == 1'b0 && r_en == 1'b1)
	begin
		count <= count + 1;
	end
end

assign empty = empty_logic;
assign read_ptr = count;
assign read_pointer = count;

endmodule

