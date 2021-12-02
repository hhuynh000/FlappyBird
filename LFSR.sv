// 8 bit Linear Feedback Shift Register used as a psudo random number generator
// Output a 10 bits number 
module LFSR (clk, reset, Q, incr, sel);
	input logic clk, reset, sel;
	input logic incr;
	output logic [7:0] Q;
	
	logic D;

	assign D = ~(Q[0] ^ Q[2] ^ Q[3] ^ Q[4]);
	

	
	
	always_ff @(posedge clk) begin
		
		if (reset)	
			Q <= 8'b00000000;
		else if (sel & incr)
			Q <= {D, Q[7:1]};
		else
			Q <= Q;
	end
	
endmodule

module LFSR_testbench ();

	logic [7:0] Q;
	logic clk, reset;
	logic incr;
	
	LFSR dut(.clk, .reset, .Q, .incr);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	// Test first ten term in the sequence
	initial begin
		reset <= 1;						@(posedge clk);
											@(posedge clk);
		reset <= 0; incr <= 1;		@(posedge clk);
						  repeat(10)   @(posedge clk);
		incr <= 0;                 @(posedge clk);
						  repeat(10)   @(posedge clk);
	   $stop;
	end
endmodule

