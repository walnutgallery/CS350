`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24 04/24/2015 
// Design Name: 
// Module Name:    HazardDummyModule 
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
module Hazard(PCWrite, IFWrite, Bubble, Branch, ALUZero4, Jump, rw, rs, rt, Reset_L, CLK);
	input			Branch;
	input			ALUZero4;
	input			Jump;
	input	[4:0]	rw;
	input	[4:0]	rs;
	input	[4:0]	rt;
	input			Reset_L;
	input			CLK;
	output reg		PCWrite;
	output reg		IFWrite;
	output reg		Bubble;
	
	/*state definition for FSM*/ //done 0-6
				parameter NoHazard_state = 3'b000,
						  Bubble0_state = 3'b001,
						  Bubble1_state= 3'b010,
						  Branch0_state= 3'b011,
						  Branch1_state= 3'b100,
						  Branch2_state= 3'b101,
						  Jump0_state= 3'b110;
				
				/*Define a name for each of the states so it is easier to 					debug and follow*/ 
				 
	
	/*internal signals*/ //done
	wire cmp1, cmp2,cmp3;
	
	/*internal state*/
	reg [2:0] FSM_state, FSM_nxt_state;
	reg [4:0] rw1, rw2, rw3 ; //rw history registers //done
	
	/*create compare logic*/
	assign  cmp1 = (((rs==rw1)||(rt==rw1))&&(rw1!= 0)) ? 1:0;
	assign cmp2 = (((rs==rw2) || (rt==rw2))&&(rw2!=0)) ? 1:0;
	assign cmp3 = (((rs==rw3) || (rt==rw3))&&(rw3!=0)) ? 1:0;
	/* cmp1 finds the dependancy btween current instruction and theonebefore make 	cmpx if needed*/


	/*keep track of rw*/
	always @(negedge CLK) begin
		if(Reset_L ==  0) begin
			rw1 <=  0;
			rw2 <= 0;
			rw3 <= 0;
			//... done
		end
		else begin //insert bubble and shift other signals over
			rw1 <= Bubble?0:rw;//insert bubble if needed
			rw2 <= rw1;
			rw3 <= rw2;
			//... done
			
		end
	end
	
		
	/*FSM state register*/
	always @(negedge CLK) begin
		if(Reset_L == 0) 
			FSM_state <= 0;
		else
			FSM_state <= FSM_nxt_state;
	end
	
	/*FSM next state and output logic*/
	always @(*) begin //combinatory logic
		case(FSM_state) //all the different states.  priortize jump >cmp > branch
			NoHazard_state: begin 
				if(Jump== 1'b1) begin //prioritize jump
					//uncondition return to no hazard state
					/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
					FSM_nxt_state<= #2 Jump0_state;
					PCWrite<= #2 1;
					IFWrite<=#2 0;
					Bubble<=#2 1'bX;
				end //jump
				
				
				else if(cmp1== 1'b1) begin //3-delay data hazard
					//uncondition return to no hazard state
					/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
					FSM_nxt_state<= #2 Bubble0_state; 
					PCWrite<= #2 0;
					IFWrite<=#2 0;
					Bubble<=#2 1;
				end//3 data delay
				else if(cmp2==1'b1) begin
					FSM_nxt_state<= #2 Bubble1_state; 
					PCWrite<= #2 0;
					IFWrite<=#2 0;
					Bubble<=#2 1;
				end//2 data delay
				
				else if(cmp3==1'b1) begin
					FSM_nxt_state<= #2 NoHazard_state; 
					PCWrite<= #2 0;
					IFWrite<=#2 0;
					Bubble<=#2 1;
				end //1 data delay
				
				else if(Branch==1'b1) begin 
					FSM_nxt_state<= #2 Branch0_state; 
					PCWrite<= #2 0;
					IFWrite<=#2 0;
					Bubble<=#2 0;
				end //branch
				
				else begin
					FSM_nxt_state<= #2 NoHazard_state; 
					PCWrite<= #2 1;
					IFWrite<=#2 1;
					Bubble<=#2 0;
				end //normal
				
				//...
				/* Complite the "NoHazard_state" state as needed*/ //done half
			end
			Bubble0_state: begin //the rest of the states
			//uncondition return to no hazard state //done
			/* Provde the value of FSM_nxt_state and outputs 				    			(PCWrite,IFWrite,Buble)*/ 
				FSM_nxt_state<= #2 Bubble1_state; 
				PCWrite<= #2 0;
				IFWrite<=#2 0;
				Bubble<=#2 1;
			end //done
			
			Bubble1_state:begin
				FSM_nxt_state<= #2 NoHazard_state; 
				PCWrite<= #2 0;
				IFWrite<=#2 0;
				Bubble<=#2 1;
			end //done
			
			Jump0_state:begin
				FSM_nxt_state<= #2 NoHazard_state; 
				PCWrite<= #2 1;
				IFWrite<=#2 1;
				Bubble<=#2 1'bX; 
			end //done
			
			Branch0_state:begin
				FSM_nxt_state<= #2 Branch1_state; 
				PCWrite<= #2 0;
				IFWrite<=#2 0;
				Bubble<=#2 1;
			end //done
			
			Branch1_state:begin
				if(ALUZero4==1) begin
					FSM_nxt_state<= #2 Branch2_state; 
					PCWrite<= #2 1;
					IFWrite<=#2 0;
					Bubble<=#2 1;
					//$display("branching1");
				end //taken
				else if(ALUZero4==0) begin
					FSM_nxt_state<= #2 NoHazard_state; 
					PCWrite<= #2 1;
					IFWrite<=#2 1;
					Bubble<=#2 1;
					//$display("not branching");
				end //not taken
			end 
			
			Branch2_state:begin
				FSM_nxt_state<= #2 NoHazard_state; 
				PCWrite<= #2 1;
				IFWrite<=#2 1;
				Bubble<=#2 1;
			end //done
			
			
			//....
			/* Complitr the states as needed*/
			
			default: begin
				FSM_nxt_state <= #2 NoHazard_state;
				PCWrite <= #2 1'bx;
				IFWrite <= #2 1'bx;
				Bubble  <= #2 1'bx;
			end
		endcase
	end
endmodule
