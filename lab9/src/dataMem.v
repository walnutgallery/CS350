`timescale 1ns / 1ps

module DataMemory(ReadData , Address , WriteData ,MemoryRead , MemoryWrite , Clock ) ;
output reg [31:0] ReadData; //inputs outputs
input [31:0] Address, WriteData; 
input MemoryRead, MemoryWrite, Clock;

reg [31:0] Memory [2048:0]; //size of the memory 

//reads the memory and assigns at posedges after 20 seconds
always @(posedge Clock) begin
	if(MemoryRead==1'b1) begin
	 #20 ReadData <= Memory[Address];
	// $display("ReadData: %d", ReadData);
end
end
//writes to memory and assigns it after 20 seconds at negedges  
always@(negedge Clock) begin
	if(MemoryWrite==1'b1) begin
	  Memory[Address] <= #20 WriteData;
end
end



endmodule

//doesn't handle error checking when mem and write are 1
