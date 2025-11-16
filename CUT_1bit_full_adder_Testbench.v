`timescale 1ns / 1ps
module CUT_1bit_full_adder_tb;
    reg a, b, cin, f1, f2, f3;
    wire sum, cout;
    CUT_1bit_full_adder DUT (.a(a), .b(b), .cin(cin), .f1(f1), .f2(f2), .f3(f3), .sum(sum), .cout(cout));   // Instantiate the CUT
    initial begin
        	$dumpfile ("CUT_1bit_full_adder.vcd");
        	$dumpvars (0, CUT_1bit_full_adder_tb);
        	$monitor ($time, "a = %b, b = %b, cin = %b, f1 = %b, f2 = %b, f3 = %b, sum = %b, cout = %b", a, b, cin, f1, f2, f3, sum, cout);
        	// Case 1: No faults
        	a = 1'b0; b = 1'b0; cin = 1'b0; f1 = 1'b1; f2 = 1'b1; f3 = 1'b0;
        	#10  a = 1'b0; b = 1'b1; cin = 1'b1; f1 = 1'b1; f2 = 1'b1; f3 = 1'b0;
        	#10  a = 1'b1; b = 1'b0; cin = 1'b1; f1 = 1'b1; f2 = 1'b1; f3 = 1'b0;
        	// Case 2: Fault at a stuck-at-0
        	#10  a = 1'b1; b = 1'b0; cin = 1'b0; f1 = 1'b0; f2 = 1'b1; f3 = 1'b0;
        	#10  a = 1'b1; b = 1'b1; cin = 1'b1; f1 = 1'b0; f2 = 1'b1; f3 = 1'b0;
        	// Case 3: Fault at r stuck-at-0
        	#10  a = 1'b1; b = 1'b1; cin = 1'b0; f1 = 1'b1; f2 = 1'b0; f3 = 1'b1;
        	#10  a = 1'b1; b = 1'b1; cin = 1'b1; f1 = 1'b1; f2 = 1'b0; f3 = 1'b1;
        	// Case 4: Fault at sum stuck-at-1
        	#10  a = 1'b0; b = 1'b0; cin = 1'b0; f1 = 1'b1; f2 = 1'b1; f3 = 1'b1;
        	#10  a = 1'b1; b = 1'b1; cin = 1'b1; f1 = 1'b1; f2 = 1'b1; f3 = 1'b1;
        	// case 5: No Faults
        	#10  a = 1'b1; b = 1'b0; cin = 1'b1; f1 = 1'b1; f2 = 1'b1; f3 = 1'b0;
            #100 $finish;
    end
endmodule
