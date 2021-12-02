module LED_4x1 # (parameter CENTER = 0) (clk, reset, out, in, top, bottom);
	input logic clk, reset;
	input logic in;
	input logic [1:0] top, bottom;
	output logic [1:0] out;
	
	//enum { off=0, on=1 } ps, ns, D;
	logic ps, ns, D;
	
	always_comb begin
		case(ps)
			1'b0:		
					if (((top[1] & top[0]) & ~in) | ((bottom[1] & bottom[0]) & in)) begin
						ns = 1;
					end else begin
						ns = 0;
					end
					
			1'b1:		
					if (((top[1] & top[0]) & ~(bottom[1] & bottom[0])) | (~(top[1] & top[0]) & (bottom[1] & bottom[0])) | (bottom[1] & ~bottom[0]) | (top[1] & ~top[0])) begin
						ns = 1;
					end else begin
						ns = 0;
					end
		endcase
	end
	assign out[1] = ps;
	assign out[0] = ps;
	logic sel;
	

	
	counter delay (.clk, .reset, .out(sel));
	mux2_1 mux_in (.out(D), .i0(ps), .i1(ns), .sel);
	
	always_ff @(posedge clk) begin
		if (reset)   // Reset to original states after a player score a point or if reset is pressed
			if (CENTER)
				ps <= 1;
			else
				ps <= 0;
		else
			ps <= D;
	end
	
endmodule
