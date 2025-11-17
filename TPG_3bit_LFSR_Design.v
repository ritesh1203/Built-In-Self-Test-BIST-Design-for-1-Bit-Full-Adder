`timescale 1ns / 1ps
module TPG_3bit_LFSR (clock, reset, data_out, complete);
    input  clock, reset;
    output  reg  [2:0] data_out;
    output reg  complete;
    reg [2:0] counter;
    always  @(posedge clock or negedge reset)  begin
        if (!reset) begin
            data_out  <= 3'b001;    // seed value = 001
            counter  <= 3'b000;
            complete  <= 1'b0;
        end
        else  begin       // Polynomial: x^3 + x + 1
            data_out[1]  <=  data_out [1]  ^  data_out [3] ;
            data_out[2]  <=  data_out [1];
            data_out[3]  <=  data_out [2];
            counter  <=  counter + 1;
            if (counter == 3’b110)    // after 7 unique states(0 - 6)
                   complete  <= 1'b1;
            else
            	   complete  <= 1'b0;
         end
      end
endmodule






