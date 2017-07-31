`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:16:03 03/10/2009 
// Design Name: 
// Module Name:    SingleCycleProc 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module SingleCycleProc(CLK, Reset_L, startPC, dMemOut);
   input CLK;
   input Reset_L;
   input [31:0]	startPC;
   output [31:0]	dMemOut;
	
	//PC Logic
	wire	[31:0]	nextPC;
	reg	[31:0]	currentPC;
	
	//Instruction Decode
	wire	[31:0]	currentInstruction;
	wire	[5:0]		opcode;
	wire	[4:0]		rs,rt,rd;
	wire	[15:0]	imm16;
	wire	[4:0]		shamt;
	wire	[5:0]		func;
	wire	[25:0]	jumpImmediate;
	
	assign {opcode, rs, rt, rd, shamt, func} = currentInstruction;
	assign imm16 = currentInstruction[15:0];
	assign jumpImmediate = currentInstruction[25:0];
	
	//Register wires
	wire	[31:0]	busA, busB, busW;
	wire	[4:0]		rw;
	
	//Control Logic Wires
	wire	RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend;
	wire	[3:0]		ALUOp;
	wire	[3:0]		ALUCtrl;
	wire	UseShiftField;
	
	//ALU Wires
	wire	[31:0]	ALUAIn, signExtImm32, ALUImmRegChoice, ALUBIn;
	wire	[31:0]	ALUResult;
	wire	ALUZero;
	
	//Data Memory Wires
	wire	[31:0]	dMemOut;

	//Instruction Memory
	InstructionMemory instrMem(currentInstruction, currentPC);	
	
	//PC Logic
	NextPClogic next(nextPC, currentPC, jumpImmediate, signExtImm32, Branch, ALUZero, Jump);
	always @ (negedge CLK, negedge Reset_L) begin //given code
		if(~Reset_L)
			currentPC = startPC;
		else
			currentPC = nextPC;
	end
	
	//add single cycle control.  just a bunch of control signals as output with input 
	SingleCycleControl control(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend, ALUOp, opcode);
	
	//Register file
	/*create the RegDst mux*/
	assign rw=(RegDst==1)? currentInstruction[15:11] : currentInstruction[20:16]; //if regdst is 1, it takes 15-11 else 20-16

	RegisterFile registers(busA, busB, busW, rs, rt, rw, RegWrite, CLK);
	
	//Sign Extender
	/*instantiate the sign extender*/
	SignExtender signExt(signExtImm32,imm16, ~SignExtend); //all of my sign extended control signals are the opposite so i just took the not of it.
	//ALU
	ALUControl ALUCont(ALUCtrl, ALUOp, func); //given code
	assign #2 UseShiftField = ((ALUOp == 4'b1111) && ((func == 6'b000000) || (func == 6'b000010) || (func == 6'b000011)));
	assign #2 ALUImmRegChoice = ALUSrc ? signExtImm32 : busB;
	assign #2 ALUBIn = UseShiftField ? {27'b0, shamt} : ALUImmRegChoice;
	assign #2 ALUAIn = UseShiftField ? busB : busA;
	ALU mainALU(ALUResult, ALUZero, ALUAIn, ALUBIn, ALUCtrl);
	//debug code
/* 	always@(currentInstruction) begin
	$display("currentInstruction: %h", currentInstruction);
	$display("ALUCtrl: %h", ALUCtrl);
	$display("ALUAIn: %d, ALUBIN: %d", ALUAIn,ALUBIn);
	$display("ALUResult: %d", ALUResult);
	end   */
	
	//Data Memory
	DataMemory data(dMemOut, ALUResult, busB, MemRead, MemWrite, CLK); //dmemout is the output and takes in an address
	/*create MemToReg mux */
	assign busW=(MemToReg==1) ? dMemOut: ALUResult; //if memtoreg is 1, the output is from memory else from the alu 

endmodule