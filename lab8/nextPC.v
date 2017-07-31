module nextPC(NextPC, CurrentPC, JumpField,SignExtImm32, Branch, ALUZero, Jump);
output [31:0] NextPC;
input [31:0] CurrentPC;
input [25:0] JumpField;
input [31:0] SignExtImm32;
input Branch;
input ALUZero;
input Jump;
//different if statements for jump, branch, and the last is for the normal pc advance
if(Jump) begin
NextPC={PC[31:28], JumpField[25:0], 2'b00}; //next PC is the first 4 of current PC, jump, then 2 zeros
end
else if(Branch and ALUZero) begin //only branch if equal.  
NextPC=CurrentPC+4+SignExtImm32*4; //need to multiply by 4 to align it with the word then add
end

else begin
	NextPC=CurrentPC+4; //set PC to PC+4
end




endmodule
