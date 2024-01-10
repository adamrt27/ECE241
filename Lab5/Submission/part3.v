`timescale 1ms / 1ms // `timescale time_unit/time_precision

module part3
#(parameter CLOCK_FREQUENCY=4)(
	
	input wire ClockIn,
	input wire Reset,
	input wire Start,
	input wire [2:0] Letter,
	output wire DotDashOut,
	output wire NewBitOut
);

	wire w1;

	// code to wait 50 ms
	RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY))count(ClockIn, Start, NewBitOut);


//	wire EnableMorse;
	
//	RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) REnable(ClockIn,Start, 2'b01, EnableMorse);

	morse_encoder m(NewBitOut, Reset, Start, Letter, DotDashOut);
//	new_bit #(.CLOCK_FREQUENCY(26'd24999999)) n(ClockIn, Start, NewBitOut);
endmodule

module morse_encoder(input ClockIn,
	input Reset,
	input Start,
	input [2:0] Letter,
	output reg  out
);

	reg [11:0]num;
	reg [4:0]count;

	always@(*)
	begin
		if (Start == 1)
		begin
			case(Letter)
				3'b000: num <= 12'b101110000000;
				3'b001: num <= 12'b111010101000;
				3'b010: num <= 12'b111010111010;
				3'b011: num <= 12'b111010100000;
				3'b100: num <= 12'b100000000000;
				3'b101: num <= 12'b101011101000;
				3'b110: num <= 12'b111011101000;
				3'b111: num <= 12'b101010000000;
				default: num <= 0;
			endcase
			count <= 11;
		end
		if (Reset)
		begin
			num <= 0;
			count <= 0;
			out <= 0;
		end
	end

	always@(posedge ClockIn)
	begin
		if (!Start)
		begin
			out <= num[11];
			if (count != 0)
			begin
				num <= num << 1;
				count <= count - 1;
			end
		end
		

	end
	
		
endmodule

module RateDivider
#(parameter CLOCK_FREQUENCY = 4) (
	input ClockIn,
	input Reset,
	output Enable
);
// 1. figure out # of clock cycles per pulse
// 2. count down from # to 0
// 3. emit pulse at 0
// 4. reset to counter
	
	reg [26:0] count;

	always@(posedge ClockIn)
	begin
		if ((Reset == 1) | (count == 0 ))
		begin
			count <= (CLOCK_FREQUENCY/2) - 1;
		end
		else if (count != 0)
			count <= count - 1;
	end

	always@(*)
	begin
		if(Reset)
			count <= 0;
	end

	assign Enable = (count == 0) ? '1:'0;
endmodule
	
		
	
