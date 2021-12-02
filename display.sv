// Display the pipe and bird and their animation
// Alsowill display "Play" on initial start up and after loosing
module display (clk, reset, RedPixels, GrnPixels, in, pipeLight, HEX0, HEX1, HEX2, sel, startGame);
	input logic clk, reset, in, sel, startGame;
	input logic [15:0][15:0] pipeLight;
	output logic [6:0] HEX0, HEX1, HEX2;
   output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
   output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs
	logic [7:0] blockTop, blockBottom;
	
	

	// Player inputs
	LED_4x2 #(.TOP(1)) m7 (.clk, .reset(reset), .rowtop(blockTop[7]), .rowbottom(blockBottom[7]), .in, .top(1'b0), .bottom(blockTop[6]), .startGame);
	LED_4x2 m6 (.clk, .reset(reset), .rowtop(blockTop[6]), .rowbottom(blockBottom[6]), .in, .top(blockBottom[7]), .bottom(blockTop[5]), .startGame);
	LED_4x2 m5 (.clk, .reset(reset), .rowtop(blockTop[5]), .rowbottom(blockBottom[5]), .in, .top(blockBottom[6]), .bottom(blockTop[4]), .startGame);
	LED_4x2 #(.CENTER(1)) m4 (.clk, .reset(reset), .rowtop(blockTop[4]), .rowbottom(blockBottom[4]), .in, .top(blockBottom[5]), .bottom(blockTop[3]), .startGame);
	LED_4x2 m3 (.clk, .reset(reset), .rowtop(blockTop[3]), .rowbottom(blockBottom[3]), .in, .top(blockBottom[4]), .bottom(blockTop[2]), .startGame);
	LED_4x2 m2 (.clk, .reset(reset), .rowtop(blockTop[2]), .rowbottom(blockBottom[2]), .in, .top(blockBottom[3]), .bottom(blockTop[1]), .startGame);
	LED_4x2 m1 (.clk, .reset(reset), .rowtop(blockTop[1]), .rowbottom(blockBottom[1]), .in, .top(blockBottom[2]), .bottom(blockTop[0]), .startGame);
	LED_4x2 m0 (.clk, .reset(reset), .rowtop(blockTop[0]), .rowbottom(blockBottom[0]), .in, .top(blockBottom[1]), .bottom(1'b0), .startGame);
	
	// Score checker
	logic gameover, score;
	logic [15:0][1:0] playField, pipe;
	logic incrOut1, incrout2, incrOut3;

	assign playField = { {blockTop[7], blockTop[7]}, {blockBottom[7], blockBottom[7]}, 
								{blockTop[6], blockTop[6]}, {blockBottom[6], blockBottom[6]}, 
								{blockTop[5], blockTop[5]}, {blockBottom[5], blockBottom[5]}, 
								{blockTop[4], blockTop[4]}, {blockBottom[4], blockBottom[4]}, 
								{blockTop[3], blockTop[3]}, {blockBottom[3], blockBottom[3]}, 
								{blockTop[2], blockTop[2]}, {blockBottom[2], blockBottom[2]}, 
								{blockTop[1], blockTop[1]}, {blockBottom[1], blockBottom[1]}, 
								{blockTop[0], blockTop[0]}, {blockBottom[0], blockBottom[0]} };
								
	assign pipe = {pipeLight[0][9:8], pipeLight[1][9:8],
						pipeLight[2][9:8], pipeLight[3][9:8],
						pipeLight[4][9:8], pipeLight[5][9:8],
						pipeLight[6][9:8], pipeLight[7][9:8],
						pipeLight[8][9:8], pipeLight[9][9:8],
						pipeLight[10][9:8], pipeLight[11][9:8],
						pipeLight[12][9:8], pipeLight[13][9:8],
						pipeLight[14][9:8], pipeLight[15][9:8]};
	

	
	gameCheck scoreCheck (.clk, .reset, .gameover, .score, .playField, .pipe, .sel, .startGame);
	
	// Scoreboard
	scoreboard hex1 (.clk, .reset, .incrOut(incrOut1), .incrIn(score), .leds(HEX0), .sel);
	scoreboard hex2 (.clk, .reset, .incrOut(incrOut2), .incrIn(incrOut1), .leds(HEX1), .sel);
	scoreboard hex3 (.clk, .reset, .incrOut(incrOut3), .incrIn(incrOut2), .leds(HEX2), .sel);
	
	always_comb begin
		

		if (~startGame | gameover) begin
		
			// Display "Play"
			RedPixels[00] = 16'b0000000000000000;
			RedPixels[01] = 16'b0000000000000000;
			RedPixels[02] = 16'b0000000000000000;
			RedPixels[03] = 16'b0000000000000000;
			RedPixels[04] = 16'b0000000000000000;
			RedPixels[05] = 16'b0111010000000000;
			RedPixels[06] = 16'b0101010000000000;
			RedPixels[07] = 16'b0111010111001010;
			RedPixels[08] = 16'b0100010101001010;
			RedPixels[09] = 16'b0100010111101110;
			RedPixels[10] = 16'b0000000000000010;
			RedPixels[11] = 16'b0000000000001110;
			RedPixels[12] = 16'b0000000000000000;
			RedPixels[13] = 16'b0000000000000000;
			RedPixels[14] = 16'b0000000000000000;
			RedPixels[15] = 16'b0000000000000000;
			
			// Empty
			GrnPixels = 0;

			
		end else begin
		
			// Player's red cardinal 

			RedPixels[00] = {6'b000000, {blockTop[7], blockTop[7]}, 8'b00000000};
			RedPixels[01] = {6'b000000, {blockBottom[7], blockBottom[7]}, 8'b00000000};
			RedPixels[02] = {6'b000000, {blockTop[6], blockTop[6]}, 8'b00000000};
			RedPixels[03] = {6'b000000, {blockBottom[6], blockBottom[6]}, 8'b00000000};
			RedPixels[04] = {6'b000000, {blockTop[5], blockTop[5]}, 8'b00000000};
			RedPixels[05] = {6'b000000, {blockBottom[5], blockBottom[5]}, 8'b00000000};
			RedPixels[06] = {6'b000000, {blockTop[4], blockTop[4]}, 8'b00000000};
			RedPixels[07] = {6'b000000, {blockBottom[4], blockBottom[4]}, 8'b00000000};
			RedPixels[08] = {6'b000000, {blockTop[3], blockTop[3]}, 8'b00000000};
			RedPixels[09] = {6'b000000, {blockBottom[3], blockBottom[3]}, 8'b00000000};
			RedPixels[10] = {6'b000000, {blockTop[2], blockTop[2]}, 8'b00000000};
			RedPixels[11] = {6'b000000, {blockBottom[2], blockBottom[2]}, 8'b00000000};
			RedPixels[12] = {6'b000000, {blockTop[1], blockTop[1]}, 8'b00000000};
			RedPixels[13] = {6'b000000, {blockBottom[1], blockBottom[1]}, 8'b00000000};
			RedPixels[14] = {6'b000000, {blockTop[0], blockTop[0]}, 8'b00000000};
			RedPixels[15] = {6'b000000, {blockBottom[0], blockBottom[0]}, 8'b00000000};
			  
			// Pipe light
			
			GrnPixels[00] = pipeLight[0];
			GrnPixels[01] = pipeLight[1];
			GrnPixels[02] = pipeLight[2];
			GrnPixels[03] = pipeLight[3];
			GrnPixels[04] = pipeLight[4];
			GrnPixels[05] = pipeLight[5];
			GrnPixels[06] = pipeLight[6];
			GrnPixels[07] = pipeLight[7];
			GrnPixels[08] = pipeLight[8];
			GrnPixels[09] = pipeLight[9];
			GrnPixels[10] = pipeLight[10];
			GrnPixels[11] = pipeLight[11];
			GrnPixels[12] = pipeLight[12];
			GrnPixels[13] = pipeLight[13];
			GrnPixels[14] = pipeLight[14];
			GrnPixels[15] = pipeLight[15];
		end	
	end 
endmodule

