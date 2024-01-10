`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input clock, reset, ParallelLoadn, RotateRight, ASRight;
	input [3:0]Data_IN;	
	output [3:0]Q;

	wire reg0, reg1, reg2, reg3;

	assign reg0 = Q[0];
	assign reg1 = Q[1];
	assign reg2 = Q[2];
	assign reg3 = Q[3];

	rotating_register r0(clock, reset, RotateRight, reg1, reg3, ParallelLoadn, Data_IN[0], ASRight, 0, reg0, Q[0]);
	rotating_register r1(clock, reset, RotateRight, reg2, reg0, ParallelLoadn, Data_IN[1], ASRight, 0, reg1, Q[1]);
	rotating_register r2(clock, reset, RotateRight, reg3, reg1, ParallelLoadn, Data_IN[2], ASRight, 0, reg2, Q[2]);
	rotating_register r3(clock, reset, RotateRight, reg0, reg2, ParallelLoadn, Data_IN[3], ASRight, 1, reg3, Q[3]);
endmodule

module rotating_register(input clk, input reset, input LoadLeft, input right, input left, input loadn, input d, input ASRight, input msb, input cur, output reg q);
	always@(posedge clk)
	begin
		if (reset == 1) q <= 1'b0;
		else if (loadn == 0)
			q <= d;
		else if (LoadLeft == 0)
			q <= left;
		else if (ASRight == 0)
			q <= right;
		else if (msb)
			q <= cur;
		else
			q <= right;

	end
endmodule
