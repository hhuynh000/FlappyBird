// 1x16 shift regisiter delayed by a factor of 2^10 of the system clock 
// Represents one row of the LED array and use to animate the moving pipes

module register_1x16 (clk,reset, Q, D, sel);
	input logic clk, reset;
	input logic D, sel;
	output logic [15:0] Q;
	

	
	always_ff @(posedge clk) begin
		if (reset)
			Q = 0;
		else if (sel) begin
			Q[0] <= D;
			Q[1] <= Q[0];
			Q[2] <= Q[1];
			Q[3] <= Q[2];
			Q[4] <= Q[3];
			Q[5] <= Q[4];
			Q[6] <= Q[5];
			Q[7] <= Q[6];
			Q[8] <= Q[7];
			Q[9] <= Q[8];
			Q[10] <= Q[9];
			Q[11] <= Q[10];
			Q[12] <= Q[11];
			Q[13] <= Q[12];
			Q[14] <= Q[13];
			Q[15] <= Q[14];
		end else
			Q <= Q;
			
	end
	

	
endmodule

module register_1x16_testbench ();
	logic clk, reset;
	logic D;
	logic [15:0] Q;
	
	register_1x16 dut (.clk, .reset, .Q, .D);

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
		D <= 1;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 1;							@(posedge clk);
		D <= 1;							@(posedge clk);
		D <= 1;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 1;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 1;							@(posedge clk);
		D <= 1;							@(posedge clk);
		D <= 1;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 0;							@(posedge clk);
		D <= 1;							@(posedge clk);
		          repeat(5)		   @(posedge clk);
	
	   $stop;
	end
endmodule
