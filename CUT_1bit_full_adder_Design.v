//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.09.2025
// Design Name: 1-bit Full Adder (CUT with Fault Injection)
// Module Name: full_adder_cut
// Project Name: BIST
// Target Devices: 
// Tool Versions: 
// Description: 
//      1-bit Full Adder with faults injected at specific nodes
//      Faults: a stuck-at-0, sum stuck-at-1, r stuck-at-0
//
// Dependencies: 
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
module CUT_1bit_full_adder(a, b, cin, f1, f2, f3, sum, cout);
	input   a, b, cin;
    input   f1;   // fault injection for a
    input   f2;   // fault injection for r
    input   f3;   // fault injection for sum
    output  sum, cout;
    // Fault injection on 'a' (a stuck-at-0 when f1=0)
    wire  a1, p, sum1, r, r1, q;
    assign a1 = a & f1; 

    // XOR stage for sum calculation
    assign p    = a1 ^ b;       // first XOR
    assign sum1 = p ^ cin;      // second XOR

    // Fault injection on sum (sum stuck-at-1 when f3=1)
    assign sum = sum1 | f3;

    // Carry calculation
    assign r  = a1 & b;         // AND gate
    assign r1 = r & f2;         // fault injected r
    assign q  = p & cin;        // AND gate for carry
    assign cout = q | r1;       // OR gate for final carry

endmodule


