module dff(
	input D,
	input clk,
	input rst,     // Asynchronous reset (counter = 0)
	output reg Q
);
	initial begin
		Q <= 0;
	end
	
	always @(posedge clk, posedge rst) begin
		if (rst)
			Q <= 0;
		else
			Q <= D;
	end
endmodule