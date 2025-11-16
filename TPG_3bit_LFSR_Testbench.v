`timescale 1ns / 1ps
module TPG_3bit_LFSR_tb;
    reg clock, reset;
    wire [2:0] data_out;
    wire complete;
    TPG_3bit_LFSR DUT (.clock(clock), .reset(reset), .data_out(data_out), .complete(complete));   // Instantiate DUT
    initial begin
        clock = 1'b0;
        reset = 1'b0;                  // Reset sequence
        always #5 clock = ~ clock;      // Clock generation (10ns period                                                                         
        #10 reset = 1'b1;              // release reset                                                                                                                                                                                                                                                                                                                                                                                                            
        $dumpfile ("TPG_3bit_LFSR.vcd"); // Monitor signals + VCD dump 
        $dumpvars (0, TPG_3bit_LFSR_tb);
        $monitor ($time, "clock = %b, reset = %b, data_out = %b, complete = %b", clock, reset, data_out, complete);                                                                                                                 
        #200 $finish;                   // Finish simulation
    end
endmodule
