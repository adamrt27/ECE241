`timescale 1ns / 1ns // `timescale time_unit/time_precisio

module part1_disp(input KEY, input [1:0] SW, output [7:0]LEDR, output HEX1, output HEX2);
	part1(KEY, SW[0], SW[1], LEDR);

	hex_decoder h1(LEDR[3:0], HEX1);
	hex_decoder h2(LEDR[7:4], HEX2);

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

module hex_decoder(c, display);
	
	// setting inputs and outputs
	input[3:0]c;
	output[6:0]display;
	
	// creating wires
	wire M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, MA, Mb, MC, Md, ME, MF;

	// assigning hexadecimal
	assign M0 = ~(c[3] | c[2] | c[1] | c[0]);
	assign M1 = ~(c[3] | c[2] | c[1] | ~c[0]);
	assign M2 = ~(c[3] | c[2] | ~c[1] | c[0]);
	assign M3 = ~(c[3] | c[2] | ~c[1] | ~c[0]);
	assign M4 = ~(c[3] | ~c[2] | c[1] | c[0]);
	assign M5 = ~(c[3] | ~c[2] | c[1] | ~c[0]);
	assign M6 = ~(c[3] | ~c[2] | ~c[1] | c[0]);
	assign M7 = ~(c[3] | ~c[2] | ~c[1] | ~c[0]);
	assign M8 = ~(~c[3] | c[2] | c[1] | c[0]);
	assign M9 = ~(~c[3] | c[2] | c[1] | ~c[0]);
	assign MA = ~(~c[3] | c[2] | ~c[1] | c[0]);
	assign Mb = ~(~c[3] | c[2] | ~c[1] | ~c[0]);
	assign MC = ~(~c[3] | ~c[2] | c[1] | c[0]);
	assign Md = ~(~c[3] | ~c[2] | c[1] | ~c[0]);
	assign ME = ~(~c[3] | ~c[2] | ~c[1] | c[0]);
	assign MF = ~(~c[3] | ~c[2] | ~c[1] | ~c[0]);

	// assigning outputs
	assign display[0] = (M1 | M4 | Mb | Md);
	assign display[1] = (M5 | M6 | MC | ME | MF);
	assign display[2] = (M2 | MC | ME | MF);
	assign display[3] = (M1 | M4 | M7 | M9 | MA | MF);
	assign display[4] = (M1 | M3 | M4 | M5 | M7 | M9);
	assign display[5] = (M1 | M2 | M3 | M7 | Md);
	assign display[6] = (M0 | M1 | M7 | MC);

endmodule
