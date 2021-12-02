// a 2^21 counter that output (incr) a 1 clock cycle pulse
// every  2^21 original clock cycles
// inputs:
//        original clock (clk)
//			 reset (initialize counter to 0)
// output:
//        incr - output one clock cycle pulse every 2^21 clock cycle


module counter (clk, reset, incr);
	input logic clk, reset;
	output incr;
	logic [20:0] count;

	
	always_comb begin
		if (count == '1)
			incr = 1;
		else 
			incr = 0;
	end
	

	always_ff @(posedge clk) begin
		if (reset | count == 5'b10010)
			count <= 0;
		else if (sel)
			count <= count + 1;
		else
			count <= count;
	end
	
endmodule

module counter_testbench ();

	logic [3:0] out;
	logic clk, reset;
	
	counter dut(.clk, .reset, .out);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	// for the sake of simulation, count is set to 2^3 bit
	// goes for 12 clock cycle and observe the 1 clock cycle
   // pulse at the 8th clock cycle	
	initial begin
		reset <= 1;						@(posedge clk);
		reset <= 0;						@(posedge clk);
					    repeat(12)    @(posedge clk);
	   $stop;
	end
endmodule
