module write_ptr_full_logic #(parameter address=2) (wclk,wreset,wen,read_ptr,write_ptr,full); // 8 bit address
	input wclk;
	input wreset;
	input wen;
	input [address:0] read_ptr;
	output [address:0] write_ptr;
	output full;

	reg [address:0] count;
	wire [address:0] write_pointer;
	reg full_logic;

always@(posedge wclk or posedge wreset)
begin 
	if(wreset == 1'b1)
			begin
				count = 0;
				full_logic = 1'b0;
			end
	else if(wen == 1'b1 || wreset == 1'b0)
			begin
			     $display("1 .Write Pointer value = %0d at time %0t",write_pointer,$time);
				if({~write_pointer[address],write_pointer[address-1:0]} === read_ptr[address:0])
				begin
						full_logic = 1'b1;
						$display("2 .Write Pointer value = %0d at time %0t",write_pointer,$time);
				end
				else
				begin
				        full_logic = 1'b0;
				end
			end
			else begin
			     full_logic = 1'b0;
			end
end


always @(posedge wclk)
begin
    if(wreset == 1'b1)
			begin
				count <= 0;
			end
	else if(full_logic == 1'b0 && wen == 1'b1 )
	begin
		count <= count + 1;
	end
end		

assign write_pointer = count;
assign write_ptr = count;
assign full = full_logic;


endmodule

