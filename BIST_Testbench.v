//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.09.2025 18:25:07
// Design Name: 
// Module Name: BIST Testbench
// Project Name: BIST Testbench
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
module BIST_Controller_tb;
reg clock;
reg reset;
reg testmode;
reg [2:0] w_x_y;   // {a, b, cin}
wire [2:0] data_out;
wire [1:0] dataIn;
wire [3:0] dataOut;
wire fault_detected;
  
// Instantiate the Unit Under Test (DUT)
BIST_Controller DUT (.clock(clock), .reset(reset), .testmode(testmode), .w_x_y(w_x_y), .data_out(data_out), .dataIn(dataIn), .dataOut(dataOut), .fault_detected(fault_detected));
  
// Clock generation (10ns period)
always #5 clock = ~clock;

initial begin
	$dumpfile("BIST_Controller.vcd");
	$dumpvars(0, BIST_Controller_tb);
	$monitor($time, "clock = %b, reset = %b, testmode = %b, w_x_y = %b, data_out = %b, dataIn = %b, dataOut = %b, fault_detected = %b", clock, reset, testmode, w_x_y, data_out, dataIn, dataOut, fault_detected);
end
  
initial begin
    // Initialize Inputs
    clock = 0;
    reset = 1;
    testmode = 0;
    w_x_y = 3'b000;
  
    // Hold reset for 10 ns
    #10 reset = 0;
  
    // Apply normal mode inputs
    w_x_y = 3'b101;   // a=1, b=0, cin=1
    #20;
  
    // Enable testmode (BIST starts)
    testmode = 1;
    #100;
  
    // Finish simulation
    $finish;
end
  
endmodule
