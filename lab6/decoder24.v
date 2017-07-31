module Decode24(out, in);
input [1:0] in;
output reg [3:0] out; 
//using a case statement to basically construct a truth table
always@(in)
case(in)
2'b00: assign out = 4'b0001; //one hot.  output is 2^input
2'b01: assign out = 4'b0010;
2'b10: assign out = 4'b0100;
2'b11: assign out = 4'b1000;
endcase
endmodule
