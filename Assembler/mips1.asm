.data
res:	.word 0
.text
.globl function
function:
	
###
	li $t6, 2
	move $a2, $a1
	move $a3, $a0
	move $t8, $zero
	move $t7, $zero
	sub $a3 $a3 16
	
loop:
	lw $t0 ($a2) #x1
	lw $t1 4($a2) #y1
	lw $t2 8($a2) #x2
	lw $t3 12($a2) #y2
	lw $t4 16($a2) #x3
	lw $t5 20($a2) #y3
schitalochka:
	sub $t0, $t0, $t4 #(x1-x3)
	sub $t3, $t3, $t5 #(y2-y3)
	mul $t0, $t0, $t3 #(x1-x3)*(y2-y3)
	sub $t2, $t2, $t4 #(x2-x3)
	sub $t1, $t1, $t5 #(y1-y2)
	mul $t1, $t1, $t2 #(x2-x3)*(y1-y2)
	sub $t0, $t0, $t1 #(x1-x3)*(y2-y3) - (x2-x3)*(y1-y2)
	div $t0, $t0, $t6 #Площадь
	abs $t0, $t0
	add $t7, $t7, $t0 # Сумма площадей
	addi $t8, $t8, 1 #счетчик треугольничков
	addi $a2, $a2, 8 #sdwig tut
	sub  $a3, $a3, 8 #sdwig tam
	beqz $a3, wow
	j loop
wow:
	div $k1, $t7, $t8 # middle
	move $a2, $a1
	move $a3, $a0
	sub $a3 $a3 16
	li $t8, 0 #ili 0 ? taki nol
	move $t9,$zero
 	move $v0, $zero
secloop:
	beqz $a3, eanding
	lw $t0 ($a2) #x1
	lw $t1 4($a2) #y1
	lw $t2 8($a2) #x2
	lw $t3 12($a2) #y2
	lw $t4 16($a2) #x3
	lw $t5 20($a2) #y3
secschitalochka:
	sub $t0, $t0, $t4 #(x1-x3)
	sub $t3, $t3, $t5 #(y2-y3)
	mul $t0, $t0, $t3 #(x1-x3)*(y2-y3)
	sub $t2, $t2, $t4 #(x2-x3)
	sub $t1, $t1, $t5 #(y1-y2)
	mul $t1, $t1, $t2 #(x2-x3)*(y1-y2)
	sub $t0, $t0, $t1 #(x1-x3)*(y2-y3) - (x2-x3)*(y1-y2)
	move $t1, $zero
	div $t1, $t0, $t6 #Площадь
	abs $t1, $t1 #v $t0 to chto nado
	addi $t8, $t8, 1
	addi $a2, $a2, 8
	sub $a3, $a3, 8
	blt $t1, $k1, secloop
	add $v0, $v0, 4
	sw $t8, res($t9)
	addi $t9, $t9, 4
	j secloop
eanding:
	la $v1 res
	jr $ra
	
	
	
	
	
