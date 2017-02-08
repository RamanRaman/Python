.text
.globl function
function:
	li $a2 0x10008000
	lw $t0, ($a1)
	lw $t1, ($a0)
	move $v0, $a0
	li $t2, 2
	move $t3, $t0
	li $t6, 1
	li $t7, 1
	move $k1, $zero
	move $k0, $zero
bitreverse:
	mthi $zero
	div $t3, $t3, $t2
	mfhi $t4
	sw $t4, ($sp)
	subi $sp, $sp, 4
	beqz $t3, lol
	addi $k1, $k1, 1
	j bitreverse
lol:
	addi $sp, $sp, 4
	lw $t5, ($sp)
	addi $k0, $k0, 1
	beq $t7, $k0, first
	mul $t6, $t6, $t2
	beq $t5, $t7, lolol
	subi $k1, $k1, 1
	beqz $k1, end
	j lol
lolol:
	add $t8, $t8, $t6
	
	j lol
first:
	add $t8, $t8, 1
	j lol
end:	
	addi $a1, $a1, 4
	subi $a0, $a0, 4
	
	lw $t8 ($a2)
	addi $a2 $a2 4
	
	beqz $a0, save
	j function
save:
        move $v1 $a2
        jr $ra
	
	
