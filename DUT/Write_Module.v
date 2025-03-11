module write_ptr_full_logic #(parameter address=2) (wclk,wreset,wen,read_ptr,write_ptr,full); // 8 bit address
	input wclk;
	input wreset;
	input wen;
	input [address+1:0] read_ptr;
	output [address+1:0] write_ptr;
	output full;

	reg [address+1:0] count;
	reg [address+1:0] write_pointer;
	reg full_logic;

always@(posedge wclk or posedge wreset)
begin 
	if(wreset == 1'b1)
			begin
				count <= 0;
				full_logic <= 1'b0;
			end
	else 
			if(wen == 1'b1)
			begin
			     write_pointer <= count;
				if({~write_pointer[address],write_pointer[address-1:0]} == read_ptr[address+1:0])
				begin
						full_logic <= 1'b1;
				end
			end

end


always @(posedge wclk or negedge wreset)
begin
	if(full_logic != 1'b1 && wen == 1'b1 )
	begin
		count <= count + 1;
	end
//	else
//	begin
//		count <= count;
//	end
end		

assign write_ptr = count;
assign full = full_logic;


endmodule

