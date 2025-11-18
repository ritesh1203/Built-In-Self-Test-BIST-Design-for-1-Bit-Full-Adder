`timescale 1ns / 1ps
module BIST_Controller_tb;
	reg clock, reset, testmode;
	reg  [3:1] w_x_y;   // {a, b, cin}
	wire [3:1] dataout_tpg;
	wire [1:0] datain;
	wire [4:1] dataout_ora;
	wire fault_detected; 
	// Instantiate the Unit Under Test (DUT)
	BIST_Controller DUT (.clock(clock), .reset(reset), .testmode(testmode), .w_x_y(w_x_y), .dataout_tpg(dataout_tpg), .datain(datain), .dataout_ora(dataout_ora), .fault_detected(fault_detected));
	initial begin
		reset = 1'b0;
		#10 reset = 1'b1;
		clock = 1'b0;
		forever #5 clock = ~ clock;
	end
	initial begin
		$dumpfile("BIST_Controller.vcd");
		$dumpvars(0, BIST_Controller_tb);
		testmode = 1'b0;
    	w_x_y = 3'b000;    // Apply normal mode inputs
    	w_x_y = 3'b101;   // a=1, b=0, cin=1
    	#20 testmode = 1'b1;  // Enable testmode (BIST starts)
    	#70 testmode = 1'b0;
    	#100  $finish;   // Finish simulation
    end    
endmodule
