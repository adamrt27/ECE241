`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2(A, B, Function, ALUout);
	input [3:0]A,B;
	input [1:0]Function;
	output reg [7:0] ALUout;

	wire [3:0]w0;
	wire c_out;
	part1 add(.a(A),.b(B),.c_in(1'b0),.s(w0),.c_out(c_out));

	always@(*)
	begin
		case(Function)
			2'b00: ALUout = {4'b00,c_out,w0};
			2'b01: ALUout = {7'b0000000,|{A,B}};
			2'b10: ALUout = {7'b0000000,&{A,B}};
			2'b11: ALUout = {A,B};
			default: ALUout = 8'b00000000;
		endcase
	end
endmodule

module part1(a, b, c_in, s, c_out);
	input [3:0]a,b;
	input c_in;
	output [3:0]s;
	output c_out;
	wire c1, c2, c3;
	adder bit0(a[0], b[0], c_in, s[0], c1);
	adder bit1(a[1], b[1], c1, s[1], c2);
	adder bit2(a[2], b[2], c2, s[2], c3);
	adder bit3(a[3], b[3], c3, s[3], c_out);
endmodule


module adder(input a, b, c_in, output s, c_out);
	assign s = a^b^c_in;
	assign c_out = (a & b)|(b & c_in)|(a & c_in);
endmodule
