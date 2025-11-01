`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 05.09.2025 20:04:48
// Design Name: 
// Module Name: ORA_4bit_MISR_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module ORA_4bit_MISR_tb;
    reg clock, reset;
    reg [1:0] dataIn;    // {Cout, Sum}
    wire [3:0] dataOut;  // {Q3,Q2,Q1,Q0}
    // Instantiate the DUT (Device Under Test)
    ORA_4bit_MISR DUT (.dataIn(dataIn), .reset(reset), .clock(clock), .dataOut(dataOut));
    // Clock generation: 10ns period
    // Clock generation: 10ns period
    initial clock = 0;
    always #5 clock = ~clock;
    initial
    	begin
    		$dumpfile("ORA_4bit_MISR.vcd");
    		$dumpvars(0, ORA_4bit_MISR_tb);
    		$monitor($time, "dataIn = %b, reset = %b, clock = %b, dataOut = %b", dataIn, reset, clock, dataOut);
    	end
    // Stimulus
    initial begin
        dataIn = 2'b00;   // Initialize inputs (Cout=0, Sum=0)
        reset  = 1'b1;       // Apply reset
        #10 reset = 1'b0;    // Hold reset a bit longer, then release

        // Apply test patterns (Sum,Cout)
        #10 dataIn = 2'b10;   // Sum=0, Cout=1
        #10 dataIn = 2'b01;   // Sum=1, Cout=0
        #10 dataIn = 2'b01;   // Sum=1, Cout=0
        #10 dataIn = 2'b11;   // Sum=1, Cout=1
        #10 dataIn = 2'b01;   // Sum=1, Cout=0
        #10 dataIn = 2'b10;   // Sum=1, Cout=0
        #10 dataIn = 2'b10;   // Sum=0, Cout=1

        #20 $finish;
    end
endmodule

