//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2025 19:36:46
// Design Name: 
// Module Name: ORA_4bit_MISR
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module ORA_4bit_MISR(dataIn, reset, clock, dataOut);
	input [1:0] dataIn;        // dataIn[0] = Sum, dataIn[1] = Cout
	input reset,clock;
	output reg [3:0] dataOut;  // {Q3,Q2,Q1,Q0}
	always@(posedge clock or posedge reset)
	begin
		if(reset == 1)
			dataOut <= 4'b0000; // Reset state
		else
			begin
				dataOut[0] <= dataOut[3] ^ dataIn[0];              // feedback + dataIn[0]
				dataOut[1] <= dataOut[3] ^ dataOut[0] ^ dataIn[1]; // feedback + dataIn[1]
				dataOut[2] <= dataOut[1] ;                         // shift
				dataOut[3] <= dataOut[2] ;                         // shift
			end
	end
endmodule
