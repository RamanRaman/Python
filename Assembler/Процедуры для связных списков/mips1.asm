.globl Lcreate, Lappend, Lpop, Lfind
	li $t2, 1
	li $t5, 1
Lcreate: 
	move $t0, $a0 
	li $a0, 8 
	li $v0, 9 
	syscall 
	move $t1, $v0 
	sw $t0, 4($t1)
	sw $zero, ($t1)
	jr $ra
Lappend:
	beqz $t2, newappend
	li $a0, 8 
	li $v0, 9 
	syscall
	sw $a1, 4($v0)
	sw $zero, ($v0)
	sub $t2, $t2, 1
	move $t4, $v0
	jr $ra
newappend:
	li $a0, 8 
	li $v0, 9 
	syscall
	sw $a1, 4($v0)
	sw $t4, ($v0) ##
	move $t4, $v0
	move $t8, $v0
	jr $ra
Lpop:
	lw $v0 ($t8) 
	lw $t0 ($v0) 
	sw $t0 ($a0) 
	lw $v0 4($v0) 
	jr $ra
Lfind:
	lw $t7, 4($t4)
	beq $t7, $a1, wow
	move $v0, $zero
	lw $t6, ($t4)
	move $t4, $t6 
	jr $ra
wow:	
	lw $v0, ($t4)
	jr $ra
	

	

	


	
