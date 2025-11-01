`timescale 1ns / 1ps

module TPG_3bit_LFSR_tb;
    reg clock, reset;
    wire [2:0] data_out;
    wire complete;

    // Instantiate DUT
    TPG_3bit_LFSR DUT (
        .data_out(data_out),
        .complete(complete),
        .reset(reset),
        .clock(clock)
    );

    // Clock generation (10ns period)
    initial begin
        clock = 1'b0;
    end
    always #5 clock = ~clock;

    // Reset sequence
    initial begin                                                                                              
        reset = 1'b1;       // assert reset
        #10 reset = 1'b0;   // release reset
    end
                                                                                                                                                                                                                                        
    // Monitor signals + VCD dump                                                                                                                                              
    initial begin
        $dumpfile("TPG_3bit_LFSR.vcd");
        $dumpvars(0, TPG_3bit_LFSR_tb);
        $monitor($time, " data_out = %b , complete = %b, reset = %b, clock = %b", data_out                                                                                                                 , complete, reset, clock);
    end

    // Finish simulation
    initial begin
        #200 $finish;
    end
endmodule
