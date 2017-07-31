`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:24:12 03/27/2009
// Design Name:   NextPC
// Module Name:   E:/350/Lab9/NextPC/NextPCTest.v
// Project Name:  NextPC
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: NextPC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module NextPCTest_v;


	task passTest;
		//input is all of the information related to testing it so you can use it in the $display
		input [31:0] actualOut, expectedOut; //actual is nextPC
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
		input [31:0] currentPC; 
		input [25:0] jumpField;
		input [31:0] signExtImm32;
		input Branch, ALUZero, Jump;
		//displays all inputs and outputs
		if(actualOut == expectedOut) begin 
		$display ("%s passed, CurrentPC: %d, JumpField: %d, SignExtImm32: %d, Branch: %d, ALUZero: %d, Jump: %d, Output: %d", testType, currentPC, jumpField,signExtImm32,Branch, ALUZero,Jump, actualOut ); 
		passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [31:0] CurrentPC;
	reg [25:0] JumpField;
	reg [31:0] SignExtImm32;
	reg Branch;
	reg ALUZero;
	reg Jump;
	reg [7:0] passed;

	// Outputs
	wire [31:0] NextPC;

	// Instantiate the Unit Under Test (UUT)
	NextPClogic uut (
		.NextPC(NextPC), 
		.CurrentPC(CurrentPC), 
		.JumpField(JumpField), 
		.SignExtImm32(SignExtImm32), 
		.Branch(Branch), 
		.ALUZero(ALUZero), 
		.Jump(Jump)
	);

	initial begin
		// Initialize Inputs
		passed = 0;
		//call passtest with all relevant information including currentpc, jumpfield,signextimm32,branch,aluzero,jump
		{CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump} = {32'h00000010, 26'hXXXXXXX, 32'hXXXXXXXX, 1'b0, 1'b0, 1'b0};
		#10
		passTest(NextPC, 20, "Normal CurrentPC advance", passed,CurrentPC, JumpField,SignExtImm32,Branch,ALUZero,Jump);
		
		{CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump} = {32'hFFFFFFF0, 26'h0000000, 32'hXXXXXXXX, 1'b0, 1'b0, 1'b1};
		#10
		passTest(NextPC, 32'hF0000000, "Jump Address 1", passed,CurrentPC, JumpField,SignExtImm32,Branch,ALUZero,Jump);
		
		{CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump} = {32'h8FFFFFFC, 26'h0000100, 32'hXXXXXXXX, 1'b0, 1'b0, 1'b1};
		#10
		passTest(NextPC, 32'h80000400, "Jump Address 2", passed,CurrentPC, JumpField,SignExtImm32,Branch,ALUZero,Jump);

		{CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump} = {32'h00000010, 26'hXXXXXXX, 32'hFFFFFFFF, 1'b1, 1'b1, 1'b0};
		#10
		passTest(NextPC, 16, "Branch Back", passed,CurrentPC, JumpField,SignExtImm32,Branch,ALUZero,Jump);

		{CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump} = {32'h00000010, 26'hXXXXXXX, 32'hFFFFFFFF, 1'b1, 1'b0, 1'b0};
		#10
		passTest(NextPC, 20, "Branch Back Not Taken", passed,CurrentPC, JumpField,SignExtImm32,Branch,ALUZero,Jump);
		
		{CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump} = {32'h00000010, 26'hXXXXXXX, 32'h00000001, 1'b1, 1'b1, 1'b0};
		#10
		passTest(NextPC, 24, "Branch Forward", passed,CurrentPC, JumpField,SignExtImm32,Branch,ALUZero,Jump);

		{CurrentPC, JumpField, SignExtImm32, Branch, ALUZero, Jump} = {32'h00000010, 26'hXXXXXXX, 32'h00000001, 1'b0, 1'b1, 1'b0};
		#10
		passTest(NextPC, 20, "Branch Forward Not Taken", passed,CurrentPC, JumpField,SignExtImm32,Branch,ALUZero,Jump);
		
		allPassed(passed, 7);
	end
      
endmodule
