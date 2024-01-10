`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part3(A, B, Function, ALUout);
	parameter N = 4;
	input [N-1:0]A,B;
	input [1:0]Function;
	output reg [N*2 - 1:0] ALUout;

	wire [N-1:0]w0;

	always@(*)
	begin
		case(Function)
			2'b00: ALUout = {{N-1{1'b0}},A+B};
			2'b01: ALUout = {{N*2 - 1{1'b0}},|{A,B}};
			2'b10: ALUout = {{N*2 - 1{1'b0}},&{A,B}};
			2'b11: ALUout = {A,B};
			default: ALUout = {N*2{1'b0}};
		endcase
	end
endmodule


