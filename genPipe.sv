// Generate psuedo random pipe formation based of LFSR
module genPipe (clk, reset, out, sel, count);
	input logic clk, reset, sel;
	logic	[7:0] rng;
	output logic [15:0] out;
	
	logic [15:0] newPipe;
	input logic [4:0] count;
	logic incr;
	
	
	
	enum {idle, gen} ps, ns;

	
	LFSR genNum (.clk, .reset, .Q(rng), .incr, .sel);
	pipeMap pipe (.newPipe, .rng);
	
	// New pipe is generated every 6 leds after the first one
	always_comb begin
		case(ps)
			idle:	begin		
						if (count == 0 | count== 9) begin
							ns = gen;
							out = newPipe;
							incr = 0;
		
						end else begin
							ns = idle;
							out = 0;
							incr = 0;
						end
			end
			gen: begin
						if (count == 3 | count == 12) begin
							ns = idle;
							out = 0;
							incr = 1;
						end else begin
							ns = gen;
							out = newPipe;
							incr = 0;
						end
			end
		endcase
	end
							
	
	always_ff @(posedge clk) begin
		if (reset)
			ps <= idle;
		else if (sel)
			ps <= ns;
		else
			ps <= ps;
	
	end
	
	
endmodule

module genPipe_testbench();
	logic clk, reset;
	logic [15:0] out;
	
	genPipe dut (.clk, .reset, .out);
	
	// Clock setup
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// Test first ten term in the sequence
	initial begin
	
		reset <= 1;						@(posedge clk);
											@(posedge clk);
		reset <= 0; 		         @(posedge clk);
					repeat(100000)    @(posedge clk);

	
	   $stop;
	end

	
	

endmodule
