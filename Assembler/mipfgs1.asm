.macro enter (%reg)
	syscall
	s.s %reg, ($sp)
	add $sp, $sp, 4
.end_macro

.macro calculate %r %addres
	addi %addres,%addres,4
	l.s %r,(%addres)
.end_macro
.data
.text
registers:
	li $v0, 6
	move $t8, $sp
	move $s0,$sp
	move $s1,$sp
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	enter $f0
	li $t0, 0 
	li $t1, 1
	li $t5, 9
	li $t7, 9
	move $sp, $t8
	move $t6, $zero
	j body
kostyl:
	add $t6, $t6, 1
	j lol
body: 
	beq $t0, $t7, exit
	calculate $f1,$sp
	calculate $f2,$sp
	add $t0, $t0, 1 
	move $s0,$s1
bodytwo:
	beq $t1, $t5, kostyl
	calculate $f3,$s0
	calculate $f4,$s0
	add $t1, $t1, 1
	sub.s $f3, $f3, $f1
	sub.s $f4, $f4, $f2
	mul.s $f3, $f3, $f3
	mul.s $f4, $f4, $f4
	add.s $f4, $f4, $f3
	c.lt.s $f5, $f4
	bc1t	savenew
	j bodytwo
savenew:
	mov.s $f5, $f4
	move $t3, $t6
	move $t4, $t1
	j bodytwo
lol:
	move $t1, $zero
	#addi $t8,$t8, 4 
	move $sp, $t8
	j body
exit:
	li $v0, 1
	move $a0, $t3
	syscall
	li      $a0 '\n'
        li      $v0 11
        syscall
        li $v0, 1
	move $a0, $t4
	syscall
