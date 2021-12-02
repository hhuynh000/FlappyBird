module LED_4x2 # (parameter CENTER = 0) (clk, reset, rowtop, rowbottom, in, top, bottom);
	input logic clk, reset;
	input logic in;
	input logic top, bottom;
	output logic rowtop, rowbottom;
	
	//enum { off=0, rowbot=1, full=10, rowtop=11 } ps, ns, D;
	logic [1:0] ps, ns, D;
	
	always_comb begin
		case(ps)
			2'b00:		
					if (bottom & in) 
						ns = 2'b01;
					else if (top & ~in)
						ns = 2'b11;
					else
						ns = 2'b00;
					
					
			2'b01:	
					if (in) 
						ns = 2'b01;
					else
						ns = 2'b00;
			2'b10:
					if (~bottom & ~in)
						ns = 2'b01;
					else if (in & ~top)
						ns = 2'b11;
					else
						ns = 2'b10;
			2'b11:
					if (in)
						ns = 2'b00;
					else 
						ns = 2'b10;
						
		endcase
	end
	
	assign out[1] = ps;
	assign out[0] = ps;
	logic sel;
	

	
	counter delay (.clk, .reset, .out(sel));
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
