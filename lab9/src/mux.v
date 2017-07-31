`timescale 1ns / 1ps

module mux(out,a,b,select);
output wire out;
input wire a, b, select;
//select determines whether to consider a or b.
assign out=(a&~select)|(b&select); 
 
endmodule
