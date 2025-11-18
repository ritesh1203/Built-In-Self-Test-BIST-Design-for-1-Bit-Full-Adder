`timescale 1ns / 1ps
module TPG_3bit_LFSR (clock, reset, dataout_tpg, complete);
    input  clock, reset;
    output  reg  [3:1] dataout_tpg;
    output reg  complete;
    reg [2:0] counter;
    always  @(posedge clock or negedge reset)  begin
        if (!reset) begin
            dataout_tpg  <= 3'b001;    // seed value = 001
            counter  <= 3'b000;
            complete  <= 1'b0;
        end
        else  begin       // Polynomial: x^3 + x + 1
            dataout_tpg[3] <= dataout_tpg[2];
            dataout_tpg[2] <= dataout_tpg[1];
            dataout_tpg[1] <= dataout_tpg[3] ^ dataout_tpg[1]; 
            counter <= counter + 1;
            if (counter == 3'b110)    // after 7 unique states(0 - 6)
                complete  <= 1'b1;
            else
            	complete  <= 1'b0;
        end
    end
endmodule
