.text
	li $a0 0x10010000
	li $t0 0x10010000
	move $t4 $sp
Inputloop1:
	li $v0 5
	syscall
	sw $v0 ($a0)
	beqz $v0 done
	addi $a0 $a0 4
	j Inputloop1
done:
	addi $a0 $a0 4
	move $t1 $a0
Inputloop2:
	li $v0 5
	syscall
	sw $v0 ($a0)
	beqz $v0 start
	addi $a0 $a0 4
	j Inputloop2
start:
	move $t5 $t1
findloop1:
	lw $t2 ($t0)
	beqz $t2 fin
	lw $t3 ($t5)
	beqz $t3 nofind
	beq $t3 $t2 find
	addi $t5 $t5 4
	j Inputloop2
nofind:
	sw $t2 ($sp)
	addi $sp $sp -4
	addi $t0 $t0 4
	move $t5 $t1
	j findloop1
find:
	addi $t0 $t0 4
	move $t5 $t1
	j findloop1
fin:
	lw $a0 ($sp)
	li $v0 1
	syscall
	addi $sp $sp 4
	ble $sp $t4 fin
	addi $sp $sp -4