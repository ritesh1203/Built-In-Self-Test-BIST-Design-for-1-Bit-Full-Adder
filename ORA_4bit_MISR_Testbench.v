`timescale 1ns / 1ps
module ORA_4bit_MISR_tb;
    reg [1:0] dataIn;
    reg clock, reset;
    ORA_4bit_MISR  DUT (.dataIn(dataIn), .clock(clock), .reset(reset), .dataOut(dataOut));    // Instantiate the DUT (Device Under Test)
    initial begin
        clock = 1'b0;
        reset  = 1'b0;
        always #5 clock = ~ clock;
    	$dumpfile ("ORA_4bit_MISR.vcd");
    	$dumpvars (0, ORA_4bit_MISR_tb);
    	$monitor ($time, "dataIn = %b, reset = %b, clock = %b, dataOut = %b", dataIn, reset, clock, dataOut);
        dataIn = 2'b00;       // Initialize inputs (Sum=0, Cout=0)
        #10 reset = 1'b1;    // Hold reset a bit longer, then release
        // Apply test patterns (Sum,Cout)
        #10 dataIn = 2'b10;   // Sum=0, Cout=1
        #10 dataIn = 2'b01;   // Sum=1, Cout=0
        #10 dataIn = 2'b01;   // Sum=1, Cout=0
        #10 dataIn = 2'b11;   // Sum=1, Cout=1
        #10 dataIn = 2'b01;   // Sum=1, Cout=0
        #10 dataIn = 2'b10;   // Sum=1, Cout=0
        #10 dataIn = 2'b10;   // Sum=0, Cout=1
        #200 $finish;
    end
endmodule

