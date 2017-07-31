`timescale 1ns / 1ps

module ALUControl (ALUCtrl , ALUop, FuncCode ) ;
input [3 : 0] ALUop;
input [5 : 0] FuncCode ;
output reg [3:0] ALUCtrl;


always@(*) begin
if(ALUop==4'b1111) begin //if the aluop is 1111, then you need to look at func code
	case(FuncCode)
		6'b000000: ALUCtrl=4'b0011; //sll 
		6'b000010: ALUCtrl=4'b0100; //srl
		6'b100000: ALUCtrl=4'b0010; //add
		6'b100010: ALUCtrl=4'b0110; //sub
		6'b100100: ALUCtrl=4'b0000; //and
		6'b100101: ALUCtrl=4'b0001; //or
		6'b101010: ALUCtrl=4'b0111; //slt
		
		6'b111000: ALUCtrl=4'b0101; //mula
		6'b101011: ALUCtrl=4'b1011; //sltu
		6'b100111: ALUCtrl=4'b1100; //nor
		6'b100110: ALUCtrl=4'b1010; //xor
		6'b100011: ALUCtrl=4'b1001; //subu
		6'b100001: ALUCtrl=4'b1000; //addu
		6'b000011: ALUCtrl=4'b1101; //SRA
	endcase
end
else begin
	ALUCtrl=ALUop; //handles all of hte other aluop codes.  doesn't look at func
	end
end
endmodule