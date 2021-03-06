// Check if there is a collision between the bird and pipe, if so end the game
// Also if the bird fall off the map then the game also end
// Everytime the bird passes a pipe will increment the score by 1
module gameCheck (clk, reset, gameover, score, playField, pipe, sel, startGame);
	input logic [15:0][1:0] playField, pipe;

	input logic clk, reset, sel, startGame;
	output logic gameover, score;

	
	enum {idle, incr, endgame} ps, ns;
	
	logic collision;
	
	// Collision checker
	always_comb begin
			if (pipe[0][0] & playField[0][0] | pipe[0][1] & playField[0][1])
				collision = 1;
			else if (pipe[1][0] & playField[1][0] | pipe[1][1] & playField[1][1])
				collision = 1;
			else if (pipe[2][0] & playField[2][0] | pipe[2][1] & playField[2][1])
				collision = 1;
			else if (pipe[3][0] & playField[3][0] | pipe[3][1] & playField[3][1])
				collision = 1;
			else if (pipe[4][0] & playField[4][0] | pipe[4][1] & playField[4][1])
				collision = 1;
			else if (pipe[5][0] & playField[5][0] | pipe[5][1] & playField[5][1])
				collision = 1;
			else if (pipe[6][0] & playField[6][0] | pipe[6][1] & playField[6][1])
				collision = 1;
			else if (pipe[7][0] & playField[7][0] | pipe[7][1] & playField[7][1])
				collision = 1;
			else if (pipe[8][0] & playField[8][0] | pipe[8][1] & playField[8][1])
				collision = 1;
			else if (pipe[9][0] & playField[9][0] | pipe[9][1] & playField[9][1])
				collision = 1;
			else if (pipe[10][0] & playField[10][0] | pipe[10][1] & playField[10][1])
				collision = 1;
			else if (pipe[11][0] & playField[11][0] | pipe[11][1] & playField[11][1])
				collision = 1;
			else if (pipe[12][0] & playField[12][0] | pipe[12][1] & playField[12][1])
				collision = 1;
			else if (pipe[13][0] & playField[13][0] | pipe[13][1] & playField[13][1])
				collision = 1;
			else if (pipe[14][0] & playField[14][0] | pipe[14][1] & playField[14][1])
				collision = 1;
			else if (pipe[15][0] & playField[15][0] | pipe[15][1] & playField[15][1])
				collision = 1;
			else
				collision = 0;
		
	end
	
	always_comb begin
		case (ps)
			idle:
					if (collision | (startGame & playField == 0)) begin
						ns = endgame;
						score = 0;
						gameover = 1;
					end else if (pipe[0][1] & ~pipe[0][0] & startGame) begin 
						ns = incr;
						score = 1;
						gameover = 0;
					end else begin
						ns = idle;
						score = 0;
						gameover = 0;
					end
						
			incr: begin
					ns = idle;
					score = 0;
					gameover = 0;
			end
			
			endgame: begin
					ns = endgame;
					score = 0;
					gameover = 1;
					
			end	
		endcase
	end
	

	
	always_ff @(posedge clk) begin
		if (reset) 
			ps <= idle;
		else if (sel | collision)
			ps <= ns;
		else 
			ps <= ps;
	end
	
	
endmodule
