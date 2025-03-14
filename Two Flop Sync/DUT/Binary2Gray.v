
module b2g #(parameter W = 2) (input [W:0] binary,output [W:0] gray);
 genvar i;
 generate 
	for(i = 0; i < W; i = i+1)
		begin
			assign gray[i] = binary[i] ^ binary[i+1];
		end
endgenerate 
 assign gray[W] = binary[W];	
endmodule

