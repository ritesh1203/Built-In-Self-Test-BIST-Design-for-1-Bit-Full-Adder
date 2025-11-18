`timescale 1ns / 1ps
module BIST_Controller (clock, reset, testmode, w_x_y, dataout_tpg, datain, dataout_ora, fault_detected); 
    input  clock, reset, testmode;
    input  [3:1] w_x_y;             // {a, b, cin}
    output [3:1] dataout_tpg;       // LFSR output
    output [1:0] datain;            // MISR input
    output [4:1] dataout_ora;       // MISR output
    output reg fault_detected;
    wire a, b, cin;
    wire complete;
    wire sum, cout;
    parameter golden_signature = 4'b1101;  // Expected golden signature
    assign {a, b, cin} = testmode ? dataout_tpg[3:1] : w_x_y; // Input selection (Normal vs BIST mode)
    assign datain = {sum, cout};  // Group full adder outputs into MISR input
    TPG_3bit_LFSR 	M1 (.clock(clock), .reset(reset), .dataout_tpg(dataout_tpg), .complete(complete));   // LFSR (Test Pattern Generator)
    CUT_1bit_full_adder M2 (.a(a), .b(b), .cin(cin), .f1(1'b1), .f2(1'b1), .f3(1'b0), .sum(sum), .cout(cout)); // CUT (1-bit Full Adder with fault injection disabled)
    ORA_4bit_MISR M3 (.datain(datain), .clock(clock), .reset(reset), .dataout_ora(dataout_ora));  // MISR (Output Response Analyzer)
    always @(posedge clock) begin      // Fault detection logic
        if (testmode == 0) begin
            fault_detected <= 0;
        end 
        else begin
            if (complete == 1) begin
                if (golden_signature == dataout_ora)
                    fault_detected <= 0;   // No fault
                else
                    fault_detected <= 1;   // Fault detected
            end
        end
    end
endmodule
