`timescale 1ns / 1ps
`define AND 4'b0000
`define OR 4'b0001
`define ADD 4'b0010
`define SLL 4'b0011
`define SRL 4'b0100
`define SUB 4'b0110
`define SLT 4'b0111
`define ADDU 4'b1000
`define SUBU 4'b1001
`define XOR 4'b1010
`define SLTU 4'b1011
`define NOR 4'b1100
`define SRA 4'b1101
`define LUI 4'b1110

module ALU(BusW, Zero, BusA, BusB, ALUCtrl);
    
    parameter n = 32; //inputs and outputs

    output  [n-1:0] BusW;
    input   [n-1:0] BusA, BusB;
    input   [3:0] ALUCtrl;
    output  Zero;
	 wire [31:0] BusA_cmp,BusB_cmp;
	 
    reg     [n-1:0] BusW; 
    
    always @(ALUCtrl or BusA or BusB) begin //pretty self explanatory.  case for each and then busw gets set equal to the result of busA (operation) busB
        case(ALUCtrl)
         `AND: begin
            BusW <= #20 BusA & BusB;
         end
		 `OR: begin
		    BusW <= #20 BusA | BusB;
		 end
		 `ADD: begin
		    BusW <= #20 BusA + BusB;
		 end
		`SLL: begin
		    BusW <= #20 BusA << BusB;
		 end
		`SRL: begin
		    BusW <= #20 BusA >> BusB;
		 end
		`SUB: begin
			BusW <= #20 BusA - BusB;
		 end 
		 `SLT: begin
			BusW <= #20 ({~BusA[31], BusA[30:0]} < {~BusB[31], BusB[30:0]}) ?  1:0; //if bus B is greater, than 1 else 0.  
		 end
		`ADDU: begin
			BusW <= #20 BusA+BusB; //addu is the same as add i believe?
		 end 
		`SUBU: begin
			BusW <= #20 BusA-BusB; //subu is the same as sub i believe
		 end
		`XOR: begin
			BusW <= #20 BusA^BusB;
			//$display("xori: %h",BusW);
		 end
        `SLTU: begin
			BusW <= #20 ($signed({~BusA[31], BusA[30:0]}) < $signed({~BusB[31], BusB[30:0]})) ?  1:0; //same thing as the slt but with signed don't techincally
			//need the concatenation probably.
         end
		`NOR: begin
			BusW <= #20 ~(BusA|BusB);
		 end
		`SRA: begin
			BusW <= #20 $signed(BusA) >>> BusB;
		 end
		`LUI: begin
			BusW <= #20 {BusB[15:0],16'b0}; //16 LSB of bus B concatenated with 16 zeros
		 end
        endcase
    end
	assign #1 Zero = (BusW==32'b0) ? 1: 0; //decides if zero gets set to high if the output is zero
endmodule
