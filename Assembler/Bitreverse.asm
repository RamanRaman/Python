.text
.globl function
function:
	li $a2 0x10008000
	move $v0, $a0
kol:
	move $t8, $zero
	move $k0, $zero
	move $k1, $zero
	lw $t0 ($a1)
	li $t2, 2
	move $t3, $t0
	li $t6, 1
	li $t7, 1
bitreverse:
	mthi $zero
	divu $t3, $t3, $t2
	mfhi $t4
	sw $t4, ($sp)
	subiu $sp, $sp, 4
	addiu $k1, $k1, 1
	beqz $t3, lol
	j bitreverse
lol:
	addiu $sp, $sp, 4
	lw $t5, ($sp)
	addiu $k0, $k0, 1
	beq $t7, $k0, first
	mulu $t6, $t6, $t2
	beq $t5, $t7, lolol
	subiu $k1, $k1, 1
	beqz $k1, end
	j lol
lolol:
	addu $t8, $t8, $t6
	subiu $k1, $k1, 1
	beqz $k1, end
	j lol
first:
	addu $t8, $t8, 1
	subiu $k1, $k1, 1
	beqz $k1, end
	j lol
end:	
	addiu $a1, $a1, 4
	subiu $a0, $a0, 4
	
	sw $t8 ($a2)
	addiu $a2 $a2 4
	
	beqz $a0, save
	j kol
save:
        move $v1 $a2
        jr $ra
	
	
