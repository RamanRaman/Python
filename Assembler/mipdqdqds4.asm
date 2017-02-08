.data
A: .word -11.57414 -4.261184 14.97916 -24.85718 -23.37546 -11.3492 24.9997 5.225492 -19.95665 -15.67563 -3.932867 19.25889 -18.59994 -5.914759 1.158114 -0.2367831 15.03069 20.12386 16.65927 7.332731
.data
.text
main:
	l.s $sp A
	li $t0, -1
	move $t1, $zero
	li $t5, 9
	li $t6, 80
	li $t7, 9
	subi $sp, $sp, 80
body:
	beq $t0, $t7, exit
	l.s $f1, ($sp)
	add $sp, $sp, 4
	l.s $f2, ($sp)
	add $t0, $t0, 1 #Адресс первой точки
bodytwo:
	beq $t1, $t5, lol
	add $sp, $sp, 4
	l.s $f3, ($sp)
	add $sp, $sp, 4
	l.s $f4, ($sp)
	sub.s $f3, $f3, $f1
	sub.s $f4, $f4, $f2
	mul.s $f3, $f3, $f3
	mul.s $f4, $f4, $f4
	add.s $f4, $f4, $f3
	add $t1, $t1, 1
	c.le.s $f4, $f5
	bc1t	savenew
	j bodytwo
savenew:
	mov.s $f5, $f4
	move $t3, $t0
	move $t4, $t1
	j bodytwo
lol:
	move $t1, $zero
	subi $t5, $t5, 1
	subi $t6, $t6, 8
	sub $sp, $sp, $t6
	j body
exit: