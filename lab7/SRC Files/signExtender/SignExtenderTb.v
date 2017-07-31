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
module SignExtenderTb;

	task passTest; //pass test method that checks if acutal=expected
		input [`STRLEN*8:0] testType;
		input [3:0] actualOut, expectedOut;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed; //check if all tests passed
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg [15:0]Imm16; //input data
	reg Ctrl; //input control
	reg [7:0] passed; //counter for number of test passed
	

	// Outputs
	wire [31:0] BusImm; //sign extended/zero extended out
	//SignExtender(BusImm, Imm16, Ctrl)
	// Instantiate the Unit Under Test (UUT)
	SignExtender uut(
		.BusImm(BusImm),
		.Imm16(Imm16),
		.Ctrl(Ctrl)
	);


	initial begin
		// Initialize Inputs
		
		passed = 0;

		// Add stimulus here
		//zero extended part
		#90;   Imm16 = 0; Ctrl= 1; #10; passTest("Input 0", BusImm, 0, passed); //check if 0 works 
		#90;   Imm16 = -1; Ctrl= 1; #10; passTest("Input -1", BusImm, 65535, passed); //check if -1 
		#90;   Imm16 = 1; Ctrl= 1; #10; passTest("Input 1", BusImm, 1, passed); //check if 1 works
		#90;   Imm16 = -4; Ctrl= 1; #10; passTest("Input -4", BusImm, 65532, passed);// check if  1 works
		
		//sign extended part
		#90;   Imm16 = 0; Ctrl= 0; #10; passTest("Input 0", BusImm, 0, passed); //check if 0 works
		#90;   Imm16 = -1; Ctrl= 0; #10; passTest("Input -1", BusImm, -1, passed); //check if -1 works
		#90;   Imm16 = 1; Ctrl= 0; #10; passTest("Input 1", BusImm, 1, passed); //check if 1 works
		#90;   Imm16 = -4; Ctrl= 0; #10; passTest("Input -4", BusImm, -4, passed); //check if -4 works
		#90;
		
		allPassed(passed, 8);

	end
      
endmodule

