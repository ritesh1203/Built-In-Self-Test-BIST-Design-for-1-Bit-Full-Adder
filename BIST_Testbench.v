`timescale 1ns / 1ps
module BIST_Controller_tb;
reg clock, reset, testmode;
reg [2:0] w_x_y;   // {a, b, cin}
wire [2:0] data_out;
wire [1:0] dataIn;
wire [3:0] dataOut;
wire fault_detected; 
// Instantiate the Unit Under Test (DUT)
BIST_Controller DUT (.clock(clock), .reset(reset), .testmode(testmode), .w_x_y(w_x_y), .data_out(data_out), .dataIn(dataIn), .dataOut(dataOut), .fault_detected(fault_detected));
initial begin
	$dumpfile("BIST_Controller.vcd");
	$dumpvars(0, BIST_Controller_tb);
	$monitor($time, "clock = %b, reset = %b, testmode = %b, w_x_y = %b, data_out = %b, dataIn = %b, dataOut = %b, fault_detected = %b", clock, reset, testmode, w_x_y, data_out, dataIn, dataOut, fault_detected);
    clock = 1'b0;
    reset = 1'b0;
    testmode = 1'b0;
	always #5 clock = ~ clock;
    w_x_y = 3'b000;    // Apply normal mode inputs
	#10 reset = 1'b1;
    w_x_y = 3'b101;   // a=1, b=0, cin=1
    #20;
    testmode = 1'b1;  // Enable testmode (BIST starts)
    #100  $finish;   // Finish simulation   
end 
endmodule
