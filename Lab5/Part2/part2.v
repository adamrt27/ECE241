`timescale 1ns / 1ns // `timescale time_unit/time_precision

module part2
#(parameter CLOCK_FREQUENCY = 50000000)(
	input ClockIn,
	input Reset,
	input [1:0] Speed,
	output [3:0] CounterValue
);

// 1. First call RateDivider, to get impulses
// 2. Then use impulse in DisplayCounter

	wire EnableDC;

	RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) RDInst (ClockIn, Reset, Speed, EnableDC);

	DisplayCounter disp (ClockIn, Reset, EnableDC, CounterValue);

endmodule

module DisplayCounter (
	input Clock,
	input Reset,
	input EnableDC,
	output reg [3:0] CounterValue
);
	
	always@(posedge Clock)
	begin
		if (Reset)
			CounterValue <= 4'b0000;
		else if (EnableDC)
			CounterValue <= CounterValue + 1;
	end
endmodule


module RateDivider
#(parameter CLOCK_FREQUENCY = 50000000) (
	input ClockIn,
	input Reset,
	input [1:0] Speed,
	output Enable
);
// 1. figure out # of clock cycles per pulse
// 2. count down from # to 0
// 3. emit pulse at 0
// 4. reset to counter
	
	reg [$clog2(4*CLOCK_FREQUENCY):0] count;

	always@(posedge ClockIn)
	begin
		if ((Reset == 1) | (count == 0 ))
		begin
			case(Speed)
				2'b00: count <= 1'b1 - 1;
				2'b01: count <= CLOCK_FREQUENCY - 1;
				2'b10: count <= CLOCK_FREQUENCY*2 - 1;
				2'b11: count <= CLOCK_FREQUENCY*4 - 1;
				default: count <= 0;
			endcase
		end 
		else if (count != 0)
			count <= count - 1;
	end

	assign Enable = (count == 'b0) ? 'b1:'b0;
endmodule
	
		
	
