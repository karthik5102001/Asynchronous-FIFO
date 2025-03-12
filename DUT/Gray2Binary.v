
module g2b #(parameter W = 4) (input [W:0] gray,output [W:0] binary);

genvar i;
generate 
	for(i=0;i<=W;i=i+1)
	begin
		assign binary[i] = ^ (gray >> i);
	end	
	endgenerate 
endmodule

/*
module g2b #(parameter WIDTH = 4) (
    input  [WIDTH+1:0] gray,
    output reg [WIDTH+1:0] binary
);

    integer W = WIDTH+1;
    integer i;
    always @(*) begin
        binary[WIDTH+1] = gray[WIDTH+1]; // MSB remains the same
        for (i = W-2; i >= 0; i = i - 1) begin
            binary[i] = binary[i+1] ^ gray[i];
        end
    end

endmodule
*/

