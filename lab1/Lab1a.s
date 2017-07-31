.text               # text section
    .globl main         # call main by MARS
    main:
    addi $t1, $0, 10	    # load immediate v alue (10) into $t1
    addi $t2, $0, 11	    # load immediate value (11) into $t2
    add $t3, $t1, $t2   # add two numbers into $t3

    add $t0, $t1, $t1 # t1+t1
    add $t0, $t0, $t0 # t0*2*2
    
    add $t4, $t2, $t2
    
    add $t3, $t0, $t4
    
    jr $ra              # return from main; return address stored in $ra
