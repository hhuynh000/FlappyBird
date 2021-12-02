// Control the HEX display and keep count of the score 0-9
// This is one HEX display module which can be linked in series
// to up by decade (eg. 10 - 100) with the max being N 9 where there N modules
module scoreboard (clk, reset, incrOut, incrIn, leds, sel);
	output logic [6:0] leds;
	input logic reset, clk, incrIn, sel;
	output logic incrOut;
	
	logic [4:0] score;
	
	seg7 display (.in(score), .leds);
	

	
	always_ff @(posedge clk) begin
		if (reset | (incrOut & sel)) begin
			score <= 0;
			incrOut <= 0;
		end else if (score == 9 & incrIn & sel) begin
			incrOut = 1;
			score <= 0;
		
		end else if (incrIn & ~incrOut & sel)
			score <= score + 1;
	end
			
		
endmodule

module scoreboard_testbench ();
	logic clk, reset;
	logic incrOut, incrIn;
	logic [6:0] leds;
	
	scoreboard dut (.clk, .reset, .incrOut, .incrIn, .leds);

	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1;						@(posedge clk);
											@(posedge clk);
		reset <= 0; 		         @(posedge clk);
						               @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
		          repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
		incrIn <= 1;					@(posedge clk);
		incrIn <= 0;					@(posedge clk);
					repeat(5)		   @(posedge clk);
	
	   $stop;
	end
endmodule