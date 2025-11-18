`timescale 1ns / 1ps
module TPG_3bit_LFSR_tb;
    reg clock, reset;
    wire [3:1] dataout_tpg;
    wire complete;
    TPG_3bit_LFSR DUT(.clock(clock), .reset(reset), .dataout_tpg(dataout_tpg), .complete(complete));   // Instantiate DUT
    initial begin
    	reset = 1'b0;
    	#10 reset = 1'b1;                 // release reset  
        clock = 1'b0;                 
        forever #5 clock = ~ clock;      // Clock generation (10ns period)                                                                        
    end
    initial begin                                                                                                                                                                                                                                                                                                                                                                                                                              
        $dumpfile("TPG_3bit_LFSR.vcd"); // Monitor signals + VCD dump 
        $dumpvars(0, TPG_3bit_LFSR_tb);
        $monitor($time, "clock = %b, reset = %b, dataout_tpg = %b, complete = %b", clock, reset, dataout_tpg, complete);                                                                                                                
        #200 $finish;                   // Finish simulation
    end
endmodule
