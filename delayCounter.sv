// A counter with adjustable width (2^x) and is used to delay 
// how fast the DFF changes from the system clock 

module delayCounter # (WIDTH = 0) (clk, reset, out, startGame);
	input logic clk, reset, startGame;
	output logic out;
	logic [WIDTH - 1:0] count;
	
	always_comb begin
		if (count == {(WIDTH-1){1'b1}})
			out = 1;
		else 
			out = 0;
	end
	
	always_ff @(posedge clk) begin
		if (reset | ~startGame)
			count <= 0;
		else
			count <= count + 1;
	end
	
endmodule
