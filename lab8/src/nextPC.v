module NextPClogic(NextPC, CurrentPC, JumpField,SignExtImm32, Branch, ALUZero, Jump);
output reg [31:0] NextPC;
input [31:0] CurrentPC;
input [25:0] JumpField;
input [31:0] SignExtImm32;
input Branch;
input ALUZero;
input Jump;
reg [27:0]temp;
//different if statements for jump, branch, and the last is for the normal pc advance
always@(*) begin
if(Jump==1'b1) begin
	 temp=JumpField<<2;
	  NextPC<= #2 {CurrentPC[31:28],temp[27:0]}; //delay of 2 to shift and the if statement
	end
else if(Branch==1'b1 && ALUZero==1'b1) begin //delay of 4 because of addition and if statement and shift
	  NextPC<=#4 CurrentPC+4+SignExtImm32*4; //need to multiply by 4 to align it with the word then add
	end
else begin //delay of 2 because of addition and if statement
	  NextPC<= #2 CurrentPC+4; //set PC to PC+4
	end
	end
endmodule
