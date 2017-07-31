`timescale 1ns / 1ps

`define RTYPEOPCODE	6'b000000
`define LWOPCODE		6'b100011
`define SWOPCODE		6'b101011
`define BEQOPCODE		6'b000100
`define JOPCODE		6'b000010
`define ORIOPCODE		6'b001101
`define ADDIOPCODE	6'b001000
`define ADDIUOPCODE	6'b001001
`define ANDIOPCODE	6'b001100
`define LUIOPCODE		6'b001111
`define SLTIOPCODE	6'b001010
`define SLTIUOPCODE	6'b001011
`define XORIOPCODE	6'b001110

`define AND		4'b0000
`define OR		4'b0001
`define ADD 	4'b0010
`define SLL 	4'b0011
`define SRL 	4'b0100
`define SUB 	4'b0110
`define SLT 	4'b0111
`define ADDU	4'b1000
`define SUBU	4'b1001
`define XOR		4'b1010
`define SLTU	4'b1011
`define NOR		4'b1100
`define SRA		4'b1101
`define LUI		4'b1110
`define FUNC	4'b1111

module SingleCycleControl(RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend, ALUOp, Opcode);
   input [5:0] Opcode;
   output RegDst;
   output ALUSrc;
   output MemToReg;
   output RegWrite;
   output MemRead;
   output MemWrite;
   output Branch;
   output Jump;
	output SignExtend;
   output [3:0] ALUOp;
	 
	reg	RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump, SignExtend;
	reg  [3:0] ALUOp;
	always @ (Opcode) begin
		case(Opcode) //different types of instruction. basically just copied control signals from the table from prelab. 
			`RTYPEOPCODE: begin
				RegDst <= #2 1;
				ALUSrc <= #2 0;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 1'bX; 
				ALUOp <= #2 `FUNC;
				//$display("r type");
			end
			`LWOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 1;
				RegWrite <= #2 1;
				MemRead <= #2 1;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 1; 
				ALUOp <= #2 `ADD;
				//$display("lw");
			end
			`SWOPCODE: begin
				RegDst <= #2 1'bX;
				ALUSrc <= #2 1;
				MemToReg <= #2 1'bX;
				RegWrite <= #2 0;
				MemRead <= #2 0;
				MemWrite <= #2 1;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 1;	
				ALUOp <= #2 `ADD;
			//	$display("sw");
			end
			`BEQOPCODE: begin
				RegDst <= #2 1'bX;
				ALUSrc <= #2 0;
				MemToReg <= #2 1'bX;
				RegWrite <= #2 0;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 1;
				Jump <= #2 0;
				SignExtend <= #2 1'bX;	
				ALUOp <= #2 `SUB;
			//	$display("beq");
			end
			`JOPCODE: begin
				RegDst <= #2 1'bX;
				ALUSrc <= #2 0;	
				MemToReg <= #2 1'bX;
				RegWrite <= #2 0;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 1;
				SignExtend <= #2 1'bX;
				ALUOp <= #2 4'bX;
				//$display("j");
			end
			`ORIOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 0; 
				ALUOp <= #2 `OR;
				//$display("ori");
			end
			`ADDIOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 1;
				ALUOp <= #2 `ADD;
				//$display("addi");
			end
			`ADDIUOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 0;
				ALUOp <= #2 `ADDU;
				//$display("addu");
			end
			`ANDIOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 0;
				ALUOp <= #2 `AND;
				//$display("andi");
			end
			`LUIOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 1'bx;
				ALUOp <= #2 `LUI;
				//$display("lui");
			end
			`SLTIOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 1;	
				ALUOp <= #2 `SLT;
				//$display("slti");
			end
			`SLTIUOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 1;
				ALUOp <= #2 `SLTU;
				//$display("sltiu");
			end
			`XORIOPCODE: begin
				RegDst <= #2 0;
				ALUSrc <= #2 1;
				MemToReg <= #2 0;
				RegWrite <= #2 1;
				MemRead <= #2 0;
				MemWrite <= #2 0;
				Branch <= #2 0;
				Jump <= #2 0;
				SignExtend <= #2 0;	
				ALUOp <= #2 `XOR;
				//$display("xori");
			end
			default: begin
				RegDst <= #2 1'bX;
				ALUSrc <= #2 1'bX;
				MemToReg <= #2 1'bX;
				RegWrite <= #2 1'bX;
				MemRead <= #2 1'bX;
				MemWrite <= #2 1'bX;
				Branch <= #2 1'bX;
				Jump <= #2 1'bX;
				SignExtend <= #2 1'bX;
				ALUOp <= #2 4'bXXXX;
				//$display("failed");
			end
		endcase
	end
endmodule