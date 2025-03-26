
module Asyc_fifo_tb();

parameter Width=4;

	reg wclk = 0,rclk = 0;
	reg wreset,r_rst;
	reg [Width-1:0] wdata;
	wire [Width-1:0] rdata;
	reg wen,ren;
	wire full;
	wire empty;
	
	reg [Width-1:0] data;


Async_fifo #(Width) DUT (wclk,rclk,wreset,r_rst,wdata,wen,ren,rdata,full,empty);

always #5 wclk = ~wclk;
always #10 rclk = ~rclk;

task Data;
begin	
	data = $random;
end
endtask

task w_Reset;
 begin
		#50;
	wreset = 1'b0;
		#50;
		wreset = 1'b1;
		#60;
end
endtask

task r_Reset;
 begin
		#50;
    	r_rst = 1'b0;
		#50;
		r_rst = 1'b1;
		#60;
end
endtask


task out_r;
begin
	@(posedge rclk)
	begin      
	       if(empty == 0) begin
		      ren = 1'b1;
		      #10;
		      ren = 1'b0;
                end
	end
end		
endtask		


task In_w;
begin
	@(posedge wclk)
	begin
	   if(full == 0)begin
		wen = 1'b1;
		wdata = data;
		#5;
		wen = 1'b0; end
	end
end		
endtask	

integer i = 0;
integer j = 0;

initial begin	
fork
w_Reset;
r_Reset;
join
///
i = 0;
for(i=0 ; i < 10; i = i + 1)
begin
Data; 
In_w;
end
///
j = 0;
for(j=0 ; j < 9; j = j + 1)
begin
out_r;
end
end

initial begin
	$dumpfile("wave.vpd");
	$dumpvars(0,Asyc_fifo_tb);
end

endmodule



