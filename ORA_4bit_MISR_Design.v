`timescale 1ns / 1ps
module ORA_4bit_MISR (datain, clock, reset, dataout_misr);
	input [1:0] datain;        // dataIn[0] = Sum, dataIn[1] = Cout
	input clock, reset;
	output reg [4:1] dataout_misr;
	always @(posedge clock or negedge reset) begin
		if(!reset) begin
			dataout_misr <= 4'b0000; 
		end
		else begin
			dataout_misr[4] <= dataout_misr[3];
			dataout_misr[3] <= dataout_misr[2];
			dataout_misr[2] <= dataout_misr[4] ^ dataout_misr[1] ^ datain[1];  // feedback + dataIn[1]
			dataout_misr[1] <= dataout_misr[4] ^ datain[0];                    // feedback + dataIn[0]
		end
	end
endmodule
