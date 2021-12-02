// Implementation of an intermediate "Play" screen in between different game
// or on initial start up
module start (clk, reset, startGame, play);
	input logic clk, reset, play;
	output logic startGame;
	
	enum {off, on} ps, ns;
	
	always_comb begin
		case(ps)
				off:
						if (play)
							ns = on;
						else
							ns = off;
				on:
					ns = on;
		endcase
	end
	
	assign startGame = ps;
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= off;
		else 
			ps <= ns;
	end
			
endmodule
