`timescale 1ns / 1ps
module BIST_Controller (clock, reset, testmode, w_x_y, data_out, dataIn, dataOut, fault_detected); 
    input  clock, reset, testmode;
    input  [2:0] w_x_y;         // {a, b, cin}
    output [2:0] data_out;      // LFSR output
    output [1:0] dataIn;        // MISR input
    output [3:0] dataOut;       // MISR output
    output reg fault_detected;
    wire a, b, cin;
    wire complete;
    wire sum, cout;
    // Expected golden signature
    parameter golden_signature = 4'b0011;
    // Input selection (Normal vs BIST mode)
    assign {a, b, cin} = testmode ? data_out[2:0] : w_x_y;
    // Group full adder outputs into MISR input
    assign dataIn = {sum, cout};
    // LFSR (Test Pattern Generator)
    TPG_3bit_LFSR 	M1 (.data_out(data_out), .complete(complete), .reset(reset), .clock(clock));
    // CUT (1-bit Full Adder with fault injection disabled)
    CUT_1bit_full_adder M2 (.a(a), .b(b), .cin(cin), .f1(1'b1), .f2(1'b1), .f3(1'b0), .sum(sum), .cout(cout));
    // MISR (Output Response Analyzer)
    ORA_4bit_MISR M3 (.dataIn(dataIn), .reset(reset), .clock(clock), .dataOut(dataOut));
    // Fault detection logic
    always @(posedge clock) begin
        if (testmode == 0) begin
            fault_detected <= 0;
        end 
        else begin
            if (complete == 1) begin
                if (golden_signature == dataOut)
                    fault_detected <= 0;   // No fault
                else
                    fault_detected <= 1;   // Fault detected
            end
        end
    end
endmodule

