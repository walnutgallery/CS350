        .data
        hextable:	.ascii "1abcdefghijklmnopqrstuvwxyz" #dummy char for 1 because the loop always increments 1 so it needs to skip 1 char.
        alphabet:       .asciiz "1abcdefghijklmnopqrstuvwxyz"
        msg1:		.asciiz "Your alphabet is: "
        .text
        .globl main
        main:
        li $v0, 5		#syscall for read_int
        syscall
        add $s1, $v0, $0 #value stored in s1
        li $v0, 4		#syscall for print_str
        la $a0, msg1
        syscall
        la $a1, hextable
		
	add $t6, $0, $0 #used to increment
	add $a2, $a1, $t0	#get address in hextable
	
	increment:
	beq $t6, $s1, endloop #stops if it's equal to each other
	beq $t6, 26, endloop #stops if it's 26
	addi $t6, $t6, 1
#        srl	$t0, $s1, 4	#get upper 4 bits
	addi $a2, $a2, 1        #increment 1
        lb $a0, 0($a2)		#get character
        li $v0, 11		#syscall for print_char
        syscall
   
        j increment
        
        
        endloop:
	li   $v0, 10            # system call for exit
	syscall                 # we are out of here.
