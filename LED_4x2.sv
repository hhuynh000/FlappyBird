// Represent a 2x2 led block which correspond to the bird moving on the screen
// Take in user input of a tap to move the bird up or the bird will fall if there is no tap
module LED_4x2 # (parameter CENTER = 0, TOP = 0) (clk, reset, rowtop, rowbottom, in, top, bottom, startGame);
	input logic clk, reset;
	input logic in, startGame;
	input logic top, bottom;
	output logic rowtop, rowbottom;
	
	//enum { off=0, rowbot=1, full=10, rowtop=11 } ps, ns, D; Used numbers instead so it work well with mux
	logic [1:0] ps, ns, D;
	
	always_comb begin
		case(ps)
			// Empty
			2'b00: begin		
					if (bottom & in) 
						ns = 2'b01;
					else if (top & ~in)
						ns = 2'b11;
					else
						ns = 2'b00;
						
					rowtop = 1'b0;
					rowbottom = 1'b0;
				end
				
			// Bottom row only
			2'b01: begin	
					if (in) 
						ns = 2'b10;
					else
						ns = 2'b00;
						
					rowtop = 1'b0;
					rowbottom = 1'b1;
				end
				
			// Both top and bottom row
			2'b10: begin
					if (~bottom & ~in)
						ns = 2'b01;
					else if (in & ~top & ~TOP)
						ns = 2'b11;
					else
						ns = 2'b10;
						
					rowtop = 1'b1;
					rowbottom = 1'b1;
				end 
			// Top row only
			2'b11: begin
					if (in)
						ns = 2'b00;
					else 
						ns = 2'b10;
						
					rowtop = 1'b1;
					rowbottom = 1'b0;
				end
						
		endcase
	end
	

	

	// Delay counter with mux to delay the clock speed of DFF
	delayCounter # (.WIDTH(8)) delay (.clk, .reset, .out(sel), .startGame);
	mux2_1 mux_in0 (.out(D[0]), .i0(ps[0]), .i1(ns[0]), .sel);
	mux2_1 mux_in1 (.out(D[1]), .i0(ps[1]), .i1(ns[1]), .sel);
	
	always_ff @(posedge clk) begin
		if (reset)   // Reset to original states after a player score a point or if reset is pressed
			if (CENTER)
				ps <= 2'b10;
			else
				ps <= 2'b00;
		else begin
			ps[0] <= D[0];
			ps[1] <= D[1];
		end
	end
	
endmodule
