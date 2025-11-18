`timescale 1ns / 1ps
module ORA_4bit_MISR_tb;
    reg [1:0] datain;
    reg clock, reset;
    wire [4:1] dataout_ora;
    ORA_4bit_MISR  DUT (.datain(datain), .clock(clock), .reset(reset), .dataout_ora(dataout_ora));    // Instantiate the DUT (Device Under Test)
    initial begin
    	reset = 1'b0;
    	#10 reset = 1'b1;    // Hold reset a bit longer, then release
    	clock = 1'b0;
        forever #5 clock = ~ clock;
    end
    initial begin
    	$dumpfile("ORA_4bit_MISR.vcd");
    	$dumpvars(0, ORA_4bit_MISR_tb);
    	$monitor($time, "datain = %b, reset = %b, clock = %b, dataout_ora = %b", datain, reset, clock, dataout_ora);
        datain = 2'b00;       // Initialize inputs (Sum=0, Cout=0)
        // Apply test patterns (Sum,Cout)
        #10 datain = 2'b10;   // Sum=1, Cout=0
        #10 datain = 2'b01;   // Sum=0, Cout=1 
        #10 datain = 2'b11;   // Sum=1, Cout=1
        #10 datain = 2'b01;   // Sum=0, Cout=1 
        #10 datain = 2'b01;   // Sum=0, Cout=1 
        #10 datain = 2'b10;   // Sum=1, Cout=0 
        #10 datain = 2'b10;   // Sum=1, Cout=0 
        #100 $finish;
    end
endmodule
