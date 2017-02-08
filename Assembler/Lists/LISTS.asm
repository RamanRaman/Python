.macro push %reg
	addi $sp,$sp,-4
	sw %reg,($sp)
.end_macro

.macro pop %reg
	lw %reg,($sp)
	addi $sp,$sp,4
.end_macro

.text
.globl Lcreate,Lappend,Lpop,Lfind
Lcreate:		##value of new element in a0,adress will be in v0 
	push $a0
	li $v0,9
	li $a0,8
	syscall
	pop $a0
	sw $a0,4($v0)
	sw $0,($v0)
	jr $31
	
Lappend:		##append a1 after a0
	push $ra
	push $a0
	move $a0,$a1
	jal Lcreate
	move $t0,$v0
	pop $a0
	lw $t1,($a0)
	sw $a1,4($v0)
	sw $t1,($v0)
	sw $v0,($a0)
	pop $ra
	jr $31
	
Lpop:			## delete element after a0, return value in v0
	lw $t0,($a0)
	lw $t1,($t0)
	sw $t1,($a0)
	sw $0,($t0)
	lw $v0,4($t0)
	sw $0,4($t0)
	jr $31
	
Lfind:			## find element with a1 value after start element a0, return adress of founded element in v0, else 0
	lw $t0,4($a0)
	beq $t0,$a1,found
	lw $t0,($a0)
	lw $t1,4($t0)
lp:
	beq $t1,$a1,found
	lw $t0,($t0)
	beqz $t0,not_found
	lw $t1,4($t0)
	b lp
found:
	move $v0,$t0
	jr $31
not_found:
	move $v0,$0
	jr $31
	
	
	
