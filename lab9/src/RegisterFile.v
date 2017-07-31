`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
	output [31:0] BusA, BusB; //inputs and outputs 
	input [31:0] BusW;
	input [4:0] RA,RB,RW;
	input RegWr, Clk;

	reg [31:0] registers [31:0]; //32x32 registers

	initial begin //set 0 register to 0 at the beginning
	registers[0]<=31'b0;
	end
	
	assign #2 BusA =  registers[RA];
	assign #2 BusB =  registers[RB]; //nonblocking assignment after 2 time units
	
	
	always @ (negedge Clk) begin //write to register 
		if((RW!==0) && RegWr) 
		  registers[RW] <=  #3 BusW; //can't reassign 0
	end
	
	
endmodule
