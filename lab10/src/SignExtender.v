`timescale 1ns / 1ps

module SignExtender(BusImm, Imm16, Ctrl);
output [31:0] BusImm; //output sign extended or zero extended number
input [15:0] Imm16; //input number
input Ctrl; //sign extend or zero extend

wire extBit; //used to deteremine what the number gets sign extended with
assign #1 extBit=(Ctrl ? 1'b0:Imm16[15]); //is ctrl high? then extbit is 0 else its sign extended. the error was here should be 15(MSB)
assign BusImm={{16{extBit}}, Imm16[15:0]}; //concatenate with the 16 bit extension

endmodule
