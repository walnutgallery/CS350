.data
UIN: .word 28 #323005519
.text
.globl main

main:   lw      $a1, UIN
	addi 	$t1, $0, 10
        add     $t0, $zero, $zero
loop:   bge     $t0, $t1, finish
        addi    $t0, $t0, 1
    	addi 	$a1, $a1, -1
        j       loop
finish: 
jr $ra
