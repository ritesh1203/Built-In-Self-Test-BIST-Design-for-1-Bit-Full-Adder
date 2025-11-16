`timescale 1ns / 1ps
module ORA_4bit_MISR (dataIn, clock, reset, dataOut);
	input [1:0] dataIn;        // dataIn[0] = Sum, dataIn[1] = Cout
	input clock, reset;
	output reg [3:0] dataOut;
	always @(posedge clock or negedge reset) begin
		if(!reset) begin
			dataOut <= 4'b0000; 
		end
		else begin
			dataOut[1] <= dataOut[3] ^ dataIn[0];              // feedback + dataIn[0]
			dataOut[2] <= dataOut[3] ^ dataOut[0] ^ dataIn[1]; // feedback + dataIn[1]
			dataOut[3] <= dataOut[1] ;                         // shift
			dataOut[4] <= dataOut[2] ;                         // shift
			end
	end
endmodule
