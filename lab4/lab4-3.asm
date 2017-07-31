.data
        msg1: .asciiz "Enter the first number\n"
        msg:  .asciiz "The factorial is "
        .text
        .globl main
        .globl fact
        .globl read
        .globl print
        .globl prompt

        main:
	jal prompt #calls the different functions to prompt,read, and print
	jal read
	jal print
    
fact:   addi $sp, $sp, -8 #set stack to -8 to store 2 things
		sw $ra, 4($sp)
		sw $a0, 0($sp) #store ra and argument
		slti $t0, $a0, 1 #checks if a0 is less than 1. if true, then 1 else 0
		beq $t0, $0, L1 #goes to the decrement case
		addi $v0, $zero, 1 #base case
		addi $sp, $sp, 8 #restore stack
		jr $ra #goes back up stack

L1: 	addi $a0, $a0, -1 #decrements the arg
		jal fact #calls itself

#bk_f comes after jal fact after it reaches the base case and it 
bk_f: 	lw $a0, 0($sp) #wants to go back up the stack	
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
        
        
read:
 li $v0, 5
  syscall             #read_int
  add, $t0, $v0, $0   #put in $t0
jr $ra

prompt:
 la $a0, msg1        #load address of msg1 into $a0
        li $v0, 4
        syscall             #print msg1
        li $v0, 5
  	jr $ra
  	
print:
 add $a0, $t0, $0    #put first number in $a0
		addi $sp, $sp, -8 #store fp and $a0 into stack
		sw $fp, 4($sp)
		sw $a0, 0($sp)
        add $fp, $sp, $0    #set fp to top of stack prior
        #to function call
    
        jal fact          #do mul, result is in $v0
        
     add $t0, $v0, $0    #save the result in $t0
        la $a0, msg
        li $v0, 4
        syscall             #print msg
        add $a0, $t0, $0    #put computation result in $a0
        li $v0, 1
        syscall             #print result number
        

        lw $a0, 0($sp)
        lw $fp, 4($sp)
        addi $sp, $sp, 8 #restores stack
       
               li      $v0, 10              # terminate program run and
    syscall  
       	jr $ra
