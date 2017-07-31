addi $a0, $0, 8 #just set a0 to something to test with

fact: addi $sp, $sp, -8 #set stack to -8 to store 2 things
sw $ra, 4($sp)
sw $a0, 0($sp) #store ra and argument
slti $t0, $a0, 1 #checks if a0 is less than 1. if true, then 1 else 0
beq $t0, $0, L1 #goes to the decrement case
addi $v0, $zero, 1 #base case
addi $sp, $sp, 8 #restore stack
jr $ra #goes back up stack

L1: addi $a0, $a0, -1 #decrements the arg
jal fact #calls itself

#bk_f comes after jal fact after it reaches the base case and it 
bk_f: lw $a0, 0($sp) #wants to go back up the stack
lw $ra, 4,($sp) 
addi $sp, $sp, 8 #restore the stack

#the following basically does the same as mul $v0, $a0, $v0 
#basically the return statement
add $a0,$0,$a0 
add $a1,$0,$v0
j my_mul
add $v0, $v0, $0 #takes the output from my_mul and stores it in $v0, but not really needed
jr $ra


        my_mul:                 #multiply $a0 with $a1
        #does not handle negative $a1!
        #Note: This is an inefficient way to multipy!
        addi $sp, $sp, -4   #make room for $s0 on the stack
        sw $s0, 0($sp)      #push $s0

        add $s0, $a1, $0   #set $s0 equal to $a1
        add $v0, $0, $0    #set $v0 to 0
        mult_loop:
        beq $s0, $0, mult_eol

        add $v0, $v0, $a0
        addi $s0, $s0, -1
        j mult_loop

        mult_eol:
        lw $s0, 0($sp)      #pop $s0
        addi $sp,$sp,4
        jr $ra