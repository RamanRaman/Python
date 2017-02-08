.globl Lcreate,Lappend,Lpop,Lfind
exit:
	move $v0,$t1
	jr $ra
noneexit:
	move $v0,$zero
	jr $ra
Lcreate:		
	addi $sp,$sp,-4
	sw $a0,($sp)
	li $v0,9
	li $a0,8
	syscall
	lw $a0,($sp)
	addi $sp,$sp,4
	sw $a0,4($v0)
	sw $zero,($v0)
	jr $ra
Lappend:		
	addi $sp,$sp,-4
	sw $ra,($sp)
	addi $sp,$sp,-4
	sw $a0,($sp)
	move $a0,$a1
	jal Lcreate
	move $t1,$v0
	lw $a0,($sp)
	addi $sp,$sp,4
	lw $t0,($a0)
	sw $a1,4($v0)
	sw $t0,($v0)
	sw $v0,($a0)
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
Lpop:			
	lw $t1,($a0)
	lw $t0,($t1)
	sw $t0,($a0)
	sw $0,($t1)
	lw $v0,4($t1)
	sw $zero,4($t1)
	jr $ra
Lfind:			
	lw $t1,4($a0)
	beq $t1,$a1,exit
	lw $t1,($a0)
	lw $t0,4($t1)
lp:
	beq $t0,$a1,exit
	lw $t1,($t1)
	beqz $t1,noneexit
	lw $t0,4($t1)
	b lp
	
	
	
