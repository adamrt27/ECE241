`timescale 1ns / 1ns // `timescale time_unit/time_precisio

module part1 (
	input Clock,
	input Enable,
	input Reset,
	output [7:0] CounterValue
);

	wire a1, a2, a3, a4, a5, a6, a7;

	t_ff t0(Clock, Reset, Enable, CounterValue[0]);	
	assign a1 = Enable & CounterValue[0];
	t_ff t1(Clock, Reset, a1, CounterValue[1]);
	assign a2 = a1 & CounterValue[1];
	t_ff t2(Clock, Reset, a2, CounterValue[2]);
	assign a3 = a2 & CounterValue[2];
	t_ff t3(Clock, Reset, a3, CounterValue[3]);
	assign a4 = a3 & CounterValue[3];
	t_ff t4(Clock, Reset, a4, CounterValue[4]);
	assign a5 = a4 & CounterValue[4];
	t_ff t5(Clock, Reset, a5, CounterValue[5]);
	assign a6 = a5 & CounterValue[5];
	t_ff t6(Clock, Reset, a6, CounterValue[6]);
	assign a7 = a6 & CounterValue[6];
	t_ff t7(Clock, Reset, a7, CounterValue[7]);
	
endmodule

module t_ff(input clk, input reset_b, input t, output reg q);
	
	always@(posedge clk)
	begin
		if (reset_b)
			q <= 1'b0;
		else
			q <= t^q;
	end
endmodule
