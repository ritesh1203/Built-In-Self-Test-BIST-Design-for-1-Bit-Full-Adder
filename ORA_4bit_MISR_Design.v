`timescale 1ns / 1ps
module ORA_4bit_MISR (datain, clock, reset, dataout_ora);
	input [1:0] datain;        // datain[1] = Sum, datain[0] = Cout
	input clock, reset;
	output reg [4:1] dataout_ora;
	always @(posedge clock or negedge reset) begin
		if(!reset) begin
			dataout_ora <= 4'b0000; 
		end
		else begin
			dataout_ora[4] <= dataout_ora[3];
			dataout_ora[3] <= dataout_ora[2];
			dataout_ora[2] <= dataout_ora[4] ^ dataout_ora[1] ^ datain[0];  // feedback + dataIn[0]
			dataout_ora[1] <= dataout_ora[4] ^ datain[1];                    // feedback + dataIn[1]
		end
	end
endmodule
