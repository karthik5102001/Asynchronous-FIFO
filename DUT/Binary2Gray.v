
module b2g #(parameter W = 2) (input [W+1:0] binary,output [W+1:0] gray);
 genvar i;
 generate 
	for(i = 0; i < W+1; i = i+1)
		begin
			assign gray[i] = binary[i] ^ binary[i+1];
		end
endgenerate 
 assign gray[W+1] = binary[W+1];	
endmodule

