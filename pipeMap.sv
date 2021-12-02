// Calculate a psuedo random pipe arrangement in term of their height based on LFSR output
// It is a 8 bit LFSR but only use 6 bits because the pattern generated using my method less
// repetitive than using a 6 bit LFSR
module pipeMap (newPipe, rng);
	input logic [7:0] rng;
	output logic [15:0] newPipe;
	
	logic [3:0] top, bottom, topPipe, bottomPipe;

	
	assign top = rng[7:4];
	assign bottom = rng[3:0];
	
	// Calculate new pipe height

	
	integer i;
	always_comb begin
		if (top > bottom) begin
			topPipe = top[2:0] + 2;
			bottomPipe = 11 - topPipe;
		end else if (bottom > top) begin
			bottomPipe = bottom[2:0] + 2;
			topPipe = 11 - bottomPipe;
		end else begin
			topPipe = 6;
			bottomPipe = 5;
		end
	end
	
	// Assign LEDs array
	always_comb begin
		newPipe = {16'b1100000000000011};
		for (i=0; i<(topPipe); i=i+1)
			newPipe[i] = 1'b1;
		for (i=0; i<(bottomPipe); i=i+1)
			newPipe[15 - i] = 1'b1;
	
	
		
	end
	
endmodule

module pipeMap_testbench();
	logic [15:0] newPipe;
	logic [7:0] rng;
	integer i;
	pipeMap dut (.newPipe, .rng);
	initial begin
		for (i = 0; i<16; i = i+1) begin
			rng[7:0] = i; 		#10;
		end
	
		$stop;
	end
endmodule
