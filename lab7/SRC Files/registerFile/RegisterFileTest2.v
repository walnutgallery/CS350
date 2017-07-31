`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:13:28 03/03/2009
// Design Name:   RegisterFile
// Module Name:   E:/350/Lab7/RegisterFile/RegisterFileTest.v
// Project Name:  RegisterFile
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegisterFile
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module RegisterFileTest_v;


	task passTest; //passtest method. 
		input [31:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed; //all passed method to see if all of them are passed or if osme failed
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [31:0] BusW;
	reg [4:0] RA;
	reg [4:0] RB;
	reg [4:0] RW;
	reg RegWr;
	reg Clk;
	reg [7:0] passed;

	// Outputs
	wire [31:0] BusA;
	wire [31:0] BusB;

	// Instantiate the Unit Under Test (UUT)
	RegisterFile uut ( 
		.BusA(BusA), 
		.BusB(BusB), 
		.BusW(BusW), 
		.RA(RA), 
		.RB(RB), 
		.RW(RW), 
		.RegWr(RegWr), 
		.Clk(Clk)
	);

	initial begin
		// Initialize Inputs
		BusW = 0;
		RA = 0;
		RB = 0;
		RW = 0;
		RegWr = 0;
		Clk = 1;
		passed = 0;
		
		#10;
		//initial tests
		// Add stimulus here
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 32'h0, 1'b0};
		passTest(BusA, 32'h0, "Initial $0 Check 1", passed);
		passTest(BusB, 32'h0, "Initial $0 Check 2", passed);
		#5; Clk = 0; #5; Clk = 1;
		
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 32'h12345678, 1'b1};
		passTest(BusA, 32'h0, "Initial $0 Check 3", passed);
		passTest(BusB, 32'h0, "Initial $0 Check 4", passed);
		#5; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h0, "$0 Stays 0 Check 1", passed);
		passTest(BusB, 32'h0, "$0 Stays 0 Check 2", passed);
		//write to register 0-31 in register 0-31
				{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd0, 32'd0, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd1, 32'd1, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd2, 32'd2, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd3, 32'd3, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd4, 32'd4, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd5, 32'd5, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd6, 32'd6, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd7, 32'd7, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd8, 32'd8, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd9, 32'd9, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd10, 32'd10, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd11, 32'd11, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd12, 32'd12, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd13, 32'd13, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd14, 32'd14, 1'b1};#5; Clk = 0; #5; Clk = 1;
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd0, 5'd15, 32'd15, 1'b1};#5; Clk = 0; #5; Clk = 1;


		
		//added test 1
		{RA, RB, RW, BusW, RegWr} = {5'd0, 5'd1, 5'd0, 32'h00000000, 1'b0};
		#2;
		passTest(BusA, 32'h0, "Initial Value Check 32", passed);
		passTest(BusB, 32'h1, "Initial Value Check 33", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h0, "Value Not Updated 17", passed);
		passTest(BusB, 32'h1, "Value Stayed Same 18", passed);
		//test 2
		{RA, RB, RW, BusW, RegWr} = {5'd2, 5'd3, 5'd1, 32'h00001000, 1'b0};
		#2;
		passTest(BusA, 32'h2, "Initial Value Check 33", passed);
		passTest(BusB, 32'h3, "Initial Value Check 34", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h2, "Value Not Updated 19", passed);
		passTest(BusB, 32'h3, "Value Stayed Same 20", passed);
		//test 3
		{RA, RB, RW, BusW, RegWr} = {5'd4, 5'd5, 5'd1, 32'h00000000, 1'b0};
		#2;
		passTest(BusA, 32'h4, "Initial Value Check 34", passed);
		passTest(BusB, 32'h5, "Initial Value Check 35", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h4, "Value Not Updated 21", passed);
		passTest(BusB, 32'h5, "Value Stayed Same 22", passed);
		passTest(0,0,"zero stayerd the same 23", passed);
		//test 4
		{RA, RB, RW, BusW, RegWr} = {5'd6, 5'd7, 5'hA, 32'h00001010, 1'b1};
		#2;
		passTest(BusA, 32'h6, "Initial Value Check 36", passed);
		passTest(BusB, 32'h7, "Initial Value Check 37", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h6, "Value Not Updated 24", passed);
		passTest(BusB, 32'h7, "Value Stayed Same 25", passed);
		//test 5
		{RA, RB, RW, BusW, RegWr} = {5'd8, 5'd9, 5'HB, 32'h00103000, 1'b1};
		#2;
		passTest(BusA, 32'h8, "Initial Value Check 38", passed);
		passTest(BusB, 32'h9, "Initial Value Check 39", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h8, "Value Not Updated 26", passed);
		passTest(BusB, 32'h9, "Value Stayed Same 27", passed);
		//test 6
		
		{RA, RB, RW, BusW, RegWr} = {5'd10, 5'd11, 5'HC, 32'h00000000, 1'b0};
		#2;
		passTest(BusA, 32'h00001010, "Initial Value Check 40", passed);
		passTest(BusB, 32'h00103000, "Initial Value Check 41", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h00001010, "Value Not Updated 28", passed);
		passTest(BusB, 32'h00103000, "Value Stayed Same 29", passed);
		
		//test 7
		{RA, RB, RW, BusW, RegWr} = {5'd12, 5'd13, 5'd13, 32'h0000ABCD, 1'b1};
		#2;
		passTest(BusA, 32'h0000000C, "Initial Value Check 38", passed);
		passTest(BusB, 32'h0000000D, "Initial Value Check 39", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h0000000C, "Value Not Updated 26", passed);
		passTest(BusB, 32'h0000ABCD, "Value Stayed Same 27", passed);
		
		//test 8
		{RA, RB, RW, BusW, RegWr} = {5'd14, 5'd15, 5'HE, 32'h09080009, 1'b0};
		#2;
		passTest(BusA, 32'h0000000E, "Initial Value Check 44", passed);
		passTest(BusB, 32'h0000000F, "Initial Value Check 45", passed);
		#3; Clk = 0; #5; Clk = 1;
		passTest(BusA, 32'h0000000E, "Value Not Updated 32", passed);
		passTest(BusB, 32'h0000000F, "Value Stayed Same 33", passed);

	end
      
endmodule

