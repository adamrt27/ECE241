`timescale 1ns / 1ns // `timescale time_unit/time_precision

module final(SW, HEX, KEY, LEDR);
	input [7:0]SW;
	input [1:0]KEY;
	output [7:0]LEDR;
	output [4:0] HEX;

	part2_disp out(SW[7:4],SW[3:0],LEDR[7:0],HEX[2],HEX[0],HEX[3],HEX[4]);
endmodule

module part2_disp(A, B, Function, ALUout, HEXA, HEXB, HEXO1,HEXO2);
	input [3:0]A,B;
	input [1:0]Function;
	output reg [7:0] ALUout;
	output [3:0]HEXA, HEXB, HEXO1, HEXO2;

	part2 out(A,B,Function,ALUout);

	hex_decoder dispA(A,HEXA);
	hex_decoder dispB(B, HEXB);
	hex_decoder dispO1(ALUout[3:0], HEXO1);
	hex_decoder dispO2(ALUout[7:4], HEXO2);
endmodule

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
