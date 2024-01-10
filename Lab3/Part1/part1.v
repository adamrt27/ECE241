`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part1(a, b, c_in, s, c_out);
	input [3:0]a,b;
	input c_in;
	output [3:0]s;
	output [3:0]c_out;
	wire c1, c2, c3;
	adder bit0(a[0], b[0], c_in, s[0], c_out[0]);
	adder bit1(a[1], b[1], c_out[0], s[1], c_out[1]);
	adder bit2(a[2], b[2], c_out[1], s[2], c_out[2]);
	adder bit3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule


module adder(input a, b, c_in, output s, c_out);
	assign s = a^b^c_in;
	assign c_out = (a & b)|(b & c_in)|(a & c_in);
endmodule
