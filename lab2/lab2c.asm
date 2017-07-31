	.data
	msg1 : .word 0:24
	.text
	.globl main

	main :
	addu $s0 , $0 , $ra         
	li $v0 , 8          	#syscall for read str
	la $a0 , msg1           #load address of msg1 to store string
	li $a1 , 100            #msg1 is 100 bytes
	syscall

	add $t6, $0, $0   #counter for lower case letters

	increment :
	lb $t0, 0($a0)         #load the character into $t0
	beq $t0, $0, endloop  #ends loop 
	li $t1 , 'a'            #get value of 'a'
	blt $t0 , $t1 , incrementChar    #do nothing if letter is less than 'a'
	li $t1 , 'z'            #get value of 'z'
	bgt $t0 , $t1 , incrementChar    #do nothing if letter is great than 'z'
	addi $t6, $t6, 1        #add one to the lower case count if it's not less than a or greater than z
	addi $a0, $a0, 1        #move to next character
	j increment       #branch to compare 

	incrementChar : #moves onto next characther 
	addi $a0, $a0, 1        #next character
	j increment

	endloop :
	addu $a0, $0, $t6       
	li $v0 , 1          #syscall for print
	syscall
	li $v0, 10    
	syscall    # syl 10 = exit