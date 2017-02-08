.text
	move $s0, $gp
	li $s1 0x10300000
	li $s2 0x10200000
loopinputone:
	li $v0, 5
	syscall
	sw   $v0, ($s1)
	beq  $v0, $zero, loopinputtwo
	addi $t2, $t2, 4
	addi $s1, $s1, 4
	j loopinputone
loopinputtwo:
	li $v0, 5
	syscall
	sw $v0, ($s2)
	beq $v0, $zero, lol
	addi $t9, $t9, 4
	addi $s2, $s2, 4
	j loopinputtwo
output:
	sub $s0, $s0, $t1
	li  $a0, '\n'
        li  $v0, 11
        syscall        
secout:
	li $v0, 1
	lw $a0, ($s0)
	beq $a0, $zero, out
	add $s0, $s0, 4
	syscall
	li  $a0, '\n'
        li  $v0, 11
        syscall
	j secout
save:
        move $t8, $t4
        sw $t8, ($s0)
        addi $s0, $s0, 4
        addi $t1, $t1, 4
        move $s2, $t3
        j lol
out:
	li $v0, 10
	syscall
lol:
        sub $s2, $s2, $t9
        sub $s1, $s1, $t2	
        move $t3, $s2
lololo:
	move $s2, $t3
	lw $t4, ($s1)
	addi $s1, $s1, 4
	beq $t4, $zero, output
olololo:
	lw $t7, ($s2)
	beq $t4, $t7, lol
	beq $t7, $zero, save
	addi $s2, $s2, 4                      
	j olololo
