`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:06:33 03/02/2009
// Design Name:   Decode24
// Module Name:   E:/350/Lab6/Decode24/Decode24Test.v
// Project Name:  Decode24
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Decode24
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 15
module Decode24Test_v;

	task passTest;
		input [`STRLEN*8:0] testType;
		input [3:0] actualOut, expectedOut;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg a;
	reg b;
	reg [7:0] passed;

	// Outputs
	wire sum;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	half_adder uut(
		.sum(sum), 
		.carry(carry),
		.a(a),
		.b(b)
	);

	initial begin
		// Initialize Inputs
		a=0;
		b=0;
		passed = 0;

		// Add stimulus here
		#90; a = 0; b= 0; #10; passTest(sum+carry, 0, "Input 0", passed);
		#90; a = 0; b= 1; #10; passTest(sum+carry, 1, "Input 1", passed);
		#90; a = 1; b= 0; #10; passTest(sum+carry, 1, "Input 1", passed);
		#90; a = 1; b= 1; #10; passTest(sum+carry, 2, "Input 2", passed);
		#90;
		allPassed(passed, 4);

	end
      
endmodule

