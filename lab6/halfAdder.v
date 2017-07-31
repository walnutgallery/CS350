module half_adder(sum,carry,a,b);
output wire sum, carry;
input wire a,b;
//equivalent of the following equation
//assign carry=~((a~&b)&(a~&b));
wire carry0;
nand nand0(carry0,a,b);
nand nand1(carry,carry0,carry0);

wire sum0,sum1,sum2;
//basically the equivalent of the following
//assign sum=~((a~&(a~&b))&(a~&(a~&b)));  
nand nand2(sum0,a,b);
nand nand3(sum1,a,sum0);
nand nand4(sum2,b,sum0);
nand nand5(sum,sum1,sum2); 

 
endmodule
