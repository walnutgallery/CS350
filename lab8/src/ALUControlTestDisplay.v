`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:24:12 03/27/2009
// Design Name:   ALUControl
// Module Name:   E:/350/Lab9/ALUControl/ALUControlTest.v
// Project Name:  ALUControl
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUControl
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//bunch of defined constants for the diff aluops/funccodes
`define AND		4'b0000
`define OR		4'b0001
`define ADD 	4'b0010
`define SLL 	4'b0011
`define SRL 	4'b0100
`define MULA	4'b0101 //d
`define SUB 	4'b0110
`define SLT 	4'b0111
`define ADDU	4'b1000 //d
`define SUBU	4'b1001 //d
`define XOR		4'b1010 //d
`define SLTU	4'b1011 //d
`define NOR		4'b1100 //d
`define SRA		4'b1101 //
`define LUI		4'b1110 //

`define SLLFunc  6'b000000
`define SRLFunc  6'b000010
`define SRAFunc  6'b000011 //
`define ADDFunc  6'b100000
`define ADDUFunc 6'b100001 //
`define SUBFunc  6'b100010
`define SUBUFunc 6'b100011 //d
`define ANDFunc  6'b100100
`define ORFunc   6'b100101
`define XORFunc  6'b100110 //d
`define NORFunc  6'b100111 //d
`define SLTFunc  6'b101010
`define SLTUFunc 6'b101011 //d
`define MULAFunc 6'b111000 //d

`define STRLEN 32
module ALUControlTest_v;


	task passTest;
		input [5:0] ALUop, FuncCode;
		input [5:0] ALUCtrl;
		inout [7:0] passed;
		input [`STRLEN*4:0] Function;
		input [5:0] expectedOut;
		//only line changed.  This prints out the the code func code, aluctrl, and function that it's testing.
		if(ALUCtrl==expectedOut) begin
		$display ("ALUOP: %d \t FuncCode: %d \t ALUCtrl: %d \t Function: %s ", ALUop, FuncCode, ALUCtrl, Function);
		passed=passed+1;
		end
		else begin
		$display("failed function : %s", Function);
		end
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [3:0] ALUop;
	reg [5:0] FuncCode;
	reg [7:0] passed;

	// Outputs
	wire [3:0] ALUCtrl;

	// Instantiate the Unit Under Test (UUT)
	ALUControl uut (
		.ALUCtrl(ALUCtrl), 
		.ALUop(ALUop), 
		.FuncCode(FuncCode)
	);

	initial begin
		// Initialize Inputs
		passed = 0;

		//run the different tests to check all the different combinations of the ALUControl outputs

{ALUop, FuncCode} = {4'b1111, `SLLFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed ,"SLL", `SLL);
		
		{ALUop, FuncCode} = {4'b1111, `SRLFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "SRL", `SRL);
		
		{ALUop, FuncCode} = {4'b1111, `SRAFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "SRA", `SRA);
		
		{ALUop, FuncCode} = {4'b1111, `ADDFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "ADD", `ADD);
		
		{ALUop, FuncCode} = {4'b1111, `ADDUFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "ADDU", `ADDU);
		
		{ALUop, FuncCode} = {4'b1111, `SUBFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "SUB", `SUB);
		
		{ALUop, FuncCode} = {4'b1111, `SUBUFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "SUBU", `SUBU);
		
		{ALUop, FuncCode} = {4'b1111, `ANDFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "AND", `AND);
		
		{ALUop, FuncCode} = {4'b1111, `ORFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "OR", `OR);
		
		{ALUop, FuncCode} = {4'b1111, `XORFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"XOR", `XOR);
		
		{ALUop, FuncCode} = {4'b1111, `NORFunc };
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"NOR", `NOR);
		
		{ALUop, FuncCode} = {4'b1111, `SLTFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"SLT", `SLT);
		
		{ALUop, FuncCode} = {4'b1111, `SLTUFunc};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"SLTU", `SLTU);
		
		{ALUop, FuncCode} = {`AND, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"AND", `AND);
		
		{ALUop, FuncCode} = {`OR, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"OR",`OR);
		
		{ALUop, FuncCode} = {`ADD, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"ADD", `ADD);
				
		{ALUop, FuncCode} = {`SUB, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"SUB",`SUB);
		
		{ALUop, FuncCode} = {`SLT, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "SLT", `SLT);
		
		{ALUop, FuncCode} = {`ADDU, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "ADDU", `ADDU);
		
		{ALUop, FuncCode} = {`SUBU, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed, "SUBU", `SUBU);
		
		{ALUop, FuncCode} = {`XOR, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"XOR", `XOR);
		
		{ALUop, FuncCode} = {`SLTU, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"SLTU", `SLTU);
		
		{ALUop, FuncCode} = {`NOR, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"NOR", `NOR);
		
		{ALUop, FuncCode} = {`LUI, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"LUI", `LUI);
//case 1
		{ALUop, FuncCode} = {0010, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"Add", `0010);

{ALUop, FuncCode} = {0010, 6'bXXXXXX};
		#10
passTest(ALUCtrl, FuncCode,  ALUCtrl, passed,"Add", `0110);



	end
      
endmodule

