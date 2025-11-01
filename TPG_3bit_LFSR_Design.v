//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2025 18:25:07
// Design Name: 
// Module Name: TPG_3bit_LFSR
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
module TPG_3bit_LFSR(data_out, complete, reset, clock);
	output [2:0] data_out;
    output reg complete;
    input reset;
    input clock;
    reg [0:2] lfsr_reg;
    reg [2:0] counter;

    always @(posedge clock or posedge reset) begin
        if (reset == 1) begin
            lfsr_reg <= 3'b001;  // seed value = 1
            counter  <= 3'b000;
            complete <= 0;
        end
        else begin
            // Polynomial: x^3 + x + 1
            lfsr_reg[0] <= lfsr_reg[2];
			lfsr_reg[1] <= lfsr_reg[0] ^ lfsr_reg[2];
			lfsr_reg[2] <= lfsr_reg[1];
            if (counter == 3'b110)  // after 7 unique states
                complete <= 0;
            else
            	complete <= 1;
            end
        end
    assign data_out = lfsr_reg;
endmodule





