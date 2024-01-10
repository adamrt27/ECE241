`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2(Clock, Reset_b, Data, Function, ALUout);
	input Clock;
	input Reset_b;
	input [3:0]Data;
	input [1:0]Function;
	output [7:0]ALUout;

	wire [7:0]Pre_reg_ALUout;

	ALU a1(Data, ALUout[3:0], Function, ALUout, Pre_reg_ALUout);

	register r1(Clock, Reset_b, Pre_reg_ALUout, ALUout);
endmodule

module register(input clk, input reset_b, input [7:0]d, output reg [7:0]q);
	always@(posedge clk)
	begin
		if (reset_b == 1) q <= {8{1'b0}};
		else q <= d;
	end
endmodule

module ALU(A, B, Function, reg_state, ALUout);
	input [3:0]A,B;
	input [1:0]Function;
	input [7:0]reg_state;
	output reg [7:0]ALUout;

	always@(*)
	begin
		case(Function)
			2'b00: ALUout = A + B;
			2'b01: ALUout = A * B;
			2'b10: ALUout = B<<A;
			2'b11: ALUout = reg_state;
			default: ALUout = {8{1'b0}};
		endcase
	end
endmodule

