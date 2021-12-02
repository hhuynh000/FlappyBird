// Simulate a game of Flappy Bird
// Controls are KEY[3] to flap, KEY[2] to play and KEY[0] is reset
// Note reset is required after lose
// Score is displayed on HEX0, HEX1, and HEX2 up to a max of 999 points
// Uses LED display expansion board to play the game
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
    //assign HEX0 = '1;
    //assign HEX1 = '1;
    //assign HEX2 = '1;
    assign HEX3 = '1;
    assign HEX4 = '1;
    assign HEX5 = '1;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = CLOCK_50; // Simulation clock
	 //assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 assign RST = ~KEY[0];
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
	 /* LED board test submodule - paints the board with a static pattern.
	    Replace with your own code driving RedPixels and GrnPixels.
		 
	 	 KEY0      : Reset
		 =================================================================== */
	 // Setup variables
	 logic [15:0][15:0] outLight;
	 logic sel;
	 logic startGame;
	 logic [1:0] difficulty;

	 
	 display playfield (.clk(SYSTEM_CLOCK), .reset(~KEY[0]), .RedPixels, .GrnPixels, .in(~KEY[3]), .pipeLight(outLight), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0), .sel, .startGame);
	 
	 
	 // Backend modules
	 logic [15:0] pipeOut;
	 logic [4:0] count;
	 
	 start game (.clk(SYSTEM_CLOCK), .reset(~KEY[0]), .startGame, .play(~KEY[2]));
	 delayCounter # (.WIDTH(10)) delay (.clk(SYSTEM_CLOCK), .reset(~KEY[0]), .out(sel), .startGame);
	 counter counter18 (.clk(SYSTEM_CLOCK), .reset(~KEY[0]), .out(count), .sel);
	 genPipe pipe (.clk(SYSTEM_CLOCK), .reset(~KEY[0]), .out(pipeOut), .sel, .count);
	
	 genvar i;
	 generate
		for (i=0; i<16; i++) begin : eachShift
			register_1x16 shift (.clk(SYSTEM_CLOCK), .reset(~KEY[0]), .Q(outLight[i]), .D(pipeOut[i]), .sel);
		end
	endgenerate 

endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	logic [35:0] GPIO_1;
	
	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY(~KEY), .LEDR, .SW, .GPIO_1);
	
	parameter CLOCK_PERIOD=100;
	 initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	 end
	 
	 
	 initial begin
		KEY[3] <= 0;					@(posedge CLOCK_50);
		KEY[0] <= 1;					@(posedge CLOCK_50);
					  repeat(10)    @(posedge CLOCK_50);
		KEY[0] <= 0;          		@(posedge CLOCK_50);
					
		KEY[2] <= 1;          		@(posedge CLOCK_50);
						repeat(10)   @(posedge CLOCK_50);
		KEY[2] <= 0;          		@(posedge CLOCK_50);
		
		KEY[3] <= 1;          		@(posedge CLOCK_50)
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50)
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 1;          		@(posedge CLOCK_50)
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50)
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 1;          		@(posedge CLOCK_50)
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
		KEY[3] <= 1;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 1;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
		KEY[3] <= 1;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
		KEY[3] <= 1;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);
		KEY[3] <= 0;          		@(posedge CLOCK_50);
		KEY[3] <= 1;          		@(posedge CLOCK_50);
					  repeat(257)    @(posedge CLOCK_50);

		
		// Test Player getting 5 points with computer difficulty set to 9'b011100000 = 224

		
		             repeat(10000)  @(posedge CLOCK_50);
							
		
		$stop;
		
	end
	 
endmodule

