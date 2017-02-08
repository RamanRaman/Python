.text
	li $t3, 20
	move $t0, $sp
	li $t8, -1
	li $t5, 9
Vvod_so_smescheniem:
	li $v0, 6
	syscall
	s.s $f0, ($sp)
	addi $t1, $t1, 1
	beq $t3, $t1, redirect
	add $sp, $sp, 4
	j Vvod_so_smescheniem
redirect:
	move $sp, $t0
first_loop:	
	l.s $f1, ($sp)    
	addi $sp, $sp, 4
	l.s $f2, ($sp)  
	addi $t8, $t8, 1
	beq  $t8, 9, IEND
	
second_loop:	
	addi $sp, $sp, 4
	l.s $f3, ($sp)   
	addi $sp, $sp, 4
	l.s $f4, ($sp)  
	addi $t7, $t7, 1
	addi $t9, $t9, 1
calculate:
	beq $t7, $t5, dirty_man
	sub.s $f3, $f3, $f1
	sub.s $f4, $f4, $f2
	mul.s $f3, $f3, $f3
	mul.s $f4, $f4, $f4
	add.s $f4, $f4, $f3
	c.lt.s $f5, $f4
	bc1t	savenew
	j second_loop
savenew:
	mov.s $f5, $f4
	move $t3, $t8
	move $t4, $t9
	j second_loop	
dirty_man:
        move $t7, $zero
        move $t9, $zero
        addi $s0, $s0 1
        add $t9, $s0 $t9
        sub $t5, $t5 1
        addi $t0, $t0 8
        j redirect
IEND:	
	li $v0, 1
	move $a0, $t3
	syscall
	li      $a0 '\n'
        li      $v0 11
        syscall
        li $v0, 1
	move $a0, $t4
	syscall
