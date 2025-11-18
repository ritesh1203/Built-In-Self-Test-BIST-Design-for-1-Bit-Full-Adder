                                                          
                                                            Built-In-Self-Test (BIST) Design for 1-Bit Full Adder
1. Introduction to BIST

Built-In-Self-Test (BIST) is a Design-for-Testability (DFT) technique where the circuit has the ability to test itself without relying on external test equipment.

It reduces dependency on Automatic Test Equipment (ATE), saves testing cost, and allows on-chip testing during normal operation.

The main idea: generate test patterns internally, apply them to the circuit under test (CUT), and then analyze the response internally.

For our case, the CUT = 1-bit Full Adder.

2. 1-bit Full Adder

Inputs: A, B, Cin

Outputs: Sum, Cout

Truth table (8 combinations):

A	B	Cin	Sum	Cout
0	0	0	0	0
0	0	1	1	0
0	1	0	1	0
0	1	1	0	1
1	0	0	1	0
1	0	1	0	1
1	1	0	0	1
1	1	1	1	1



3. BIST Architecture

The typical BIST structure has three main blocks:

Test Pattern Generator (TPG)

Generates a sequence of test inputs (A, B, Cin).

Can be implemented using a Linear Feedback Shift Register (LFSR), counter, or ROM.

For a 1-bit full adder, 3 inputs → 8 possible combinations.

A 3-bit counter is enough to generate all test inputs.

Circuit Under Test (CUT)

The 1-bit Full Adder itself.

It takes test inputs from TPG and produces outputs (Sum, Cout).

Output Response Analyzer (ORA)

Compares the actual output with the expected/golden response.

Can be implemented using:

A Comparator (bit-by-bit checking).

A Multiple Input Signature Register (MISR) for compressed checking.

Finally produces a Pass/Fail signal.

4. Working Principle

BIST controller enables Test Mode.

TPG generates all 8 combinations of inputs (000 to 111).

CUT (full adder) produces Sum and Cout.

ORA checks if the outputs match the expected truth table.

If all match → Pass (No Fault).
If mismatch → Fail (Fault Detected).

5. Advantages of BIST

No need for expensive external test hardware.

Faster testing (parallel on-chip).

Useful for VLSI chips where external access is difficult.

Supports field-testing and self-repair systems.

6. Applications

VLSI chip testing.

Safety-critical systems (automotive, aerospace, medical).

Low-cost ICs where external testers are too expensive.
