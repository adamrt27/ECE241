//SW[0] reset when 0
//SW[1] input signal

//KEY[0] clock signal

//LEDR[3:0] displays current state
//LEDR[9] displays output

// module lab6part1(input [1:0]SW, input [1:0]KEY, output [9:0]LEDR, output [6:0]HEX0);
//	part1 p1(KEY[0], SW[0], SW[1], LEDR[9], LEDR[3:0]);
//	hex_decoder h(LEDR[3:0], HEX0);
// endmodule
	

module part1(Clock, Reset, w, z, CurState);
    input Clock;
    input Reset;
    input w;
    output z;
    output [3:0] CurState;

    reg [3:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state

    localparam A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110;


    //State table
    //The state table should only contain the logic for state transitions
    //Do not mix in any output logic. The output logic should be handled separately.
    //This will make it easier to read, modify and debug the code.
    always@(*)
    begin: state_table
        case ( y_Q )
			A : begin
				if (! w ) Y_D = A ;
				else Y_D = B ;
			end
			B : begin
				if (w==1) Y_D = C;
				else Y_D = A;
			end
			C : begin
				if (w==1) Y_D = D;
				else Y_D = E;
			end
			D : begin
				if (w==1) Y_D = F;
				else Y_D = E;
			end
			E : begin
				if (w==1) Y_D = G;
				else Y_D = A;
			end
			F : begin
				if (w==1) Y_D = F;
				else Y_D = E;
			end
			G : begin
				if (w==1) Y_D = C;
				else Y_D = A;
			end
            default: Y_D = A;
        endcase
    end // state_table

    // State Registers
    always @(posedge Clock)
    begin: state_FFs
        if(Reset == 1'b1)
            y_Q <=  A; // Should set reset state to state A
        else
            y_Q <= Y_D;
    end // state_FFS

    // Output logic
    // Set z to 1 to turn on LED when in relevant states
    assign z =  ((y_Q == F) | (y_Q == G));

    assign CurState = y_Q;
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
