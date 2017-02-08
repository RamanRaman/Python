.data
res: .word 0
.text
.globl function
function:
	move $s1, $a0
	move $s4, $a0
	move $s5, $a0
	move $s6, $a1
	move $t6, $zero
	move $t7, $zero
	li $s0, 2
	sub $s1, $s1, 16
	sub $s5, $s5, 16
# a0 save original
loop:
	lw $t0 ($a1)
	lw $t1 4($a1)
	lw $t2 8($a1)
	lw $t3 12($a1)
	lw $t4 16($a1)
	lw $t5 20($a1)
	
schitalochki:
	sub $t0, $t0, $t4
	sub $t3, $t3, $t5
	mul $t0, $t0, $t3
	sub $t2, $t2, $t4
	sub $t1, $t1, $t5
	mul $t1, $t1, $t2
	sub $t0, $t0, $t1
	div $t0, $t0, $s0
	abs $t0 $t0
	addi $t6, $t6, 1
	addi $a1 $a1 8
	add $t7, $t7, $t0
	sub $s1, $s1, 8 
	beqz $s1, sec
	j loop
sec:
	div $t7, $t7 $t6
	li $t6 1
	move $t6, $zero
	move $t8, $zero
	move $a1 $s6
	li $s0, 2
	move $v0, $zero
looppp:
	lw $t0 ($s6)
	lw $t1 4($s6)
	lw $t2 8($s6)
	lw $t3 12($s6)
	lw $t4 16($s6)
	lw $t5 20($s6)
schitalochki2:
	sub $t0, $t0, $t4
	sub $t3, $t3, $t5
	mul $t0, $t0, $t3
	sub $t2, $t2, $t4
	sub $t1, $t1, $t5
	mul $t1, $t1, $t2
	sub $t0, $t0, $t1
	div $t0, $t0, $s0
	abs $t0, $t0
	addi $t6, $t6, 1
	addi $s6, $s6 8
	blt $t7, $t0,looppp
	add $v0, $v0, 4
	sw $t6,res($t8)
	sub $s5, $s5, 8
	addi $t8, $t8 1
	beqz $s5, end
	j looppp
end:
	la $v1 res
	jr $ra
	
	
	

	
	
