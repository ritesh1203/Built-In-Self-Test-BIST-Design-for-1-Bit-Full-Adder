`timescale 1ns / 1ps
module CUT_1bit_full_adder(a, b, cin, f1, f2, f3, sum, cout);
	input   a, b, cin, f1, f2, f3;                                 
    output  sum, cout;
    wire  a1, p, sum1, r, r1, q;
	// sum calculation
	assign a1 = a & f1;          // fault injection on a 
    assign p  = a1 ^ b;       
    assign sum1 = p ^ cin;      
    assign sum = sum1 | f3;     // Fault injection on sum
    // Carry calculation
    assign r  = a1 & b;         
    assign r1 = r & f2;         // fault injected on r
    assign q  = p & cin;        
    assign cout = q | r1;       
endmodule
