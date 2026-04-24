module dff(
	input d,
	input clk,
	input rst,     // Asynchronous reset (counter = 0)
	output reg q
);
	initial begin
		q <= 0;
	end
	
	always @(posedge clk, posedge rst) begin
		if (rst)
			q <= 0;
		else
			q <= d;
	end
endmodule