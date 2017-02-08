.text
.globl Tappend
.globl Tcreate
.globl Tdelete
.globl Tget
.globl Tinfo
.globl Tinsert
.globl Tpop
.globl Tput
Tappend:
		move $t2 $a0
		lw $t0 -8($a0)
		lw $t1 -4($a0)
		move $v0 $t0
		mul $t0 $t0 4
		add $t2 $t2 $t0
		sw $a1 ($t2)
		div $t0 $t0 4
		addi $t0 $t0 1
		sw $t0 -8($a0)
		jr $ra
Tcreate:	
		move $t0 $a0
		mul $a0 $a0 4
		addi $a0 $a0 8
		li $v0 9
		syscall
		move $t1 $v0
		sub $t1 $t1 $t1
		sw $t1 ($v0)
		sw $t0 4($v0)
		addi $v0 $v0 8
		jr $ra
Tdelete:
		lw $t2 -8($a0)
		addi $t2 $t2 -1
		sw $t2 -8($a0)
		mul $t2 $t2 4
		add $t2 $t2 $a0
		move $t1 $a1
		mul $t1 $t1 4
		add $t1 $t1 $a0
Tdeleteloop:	lw $t0 4($t1)
		sw $t0 ($t1)
		addi $t1 $t1 4
		bne $t1 $t2 Tdeleteloop
		sub $t0 $t0 $t0
		sw $t0 ($t2)
		jr $ra
Tget:
		move $t1 $a0
		mul $t0 $a1 4
		add $t1 $t1 $t0
		lw $v0 ($t1)
		jr $ra
Tinfo:
		lw $v0 -8($a0)
		lw $v1 -4($a0)
		jr $ra
Tinsert:
		move $t2 $a2
		mul $t2 $t2 4
		move $t1 $a0
		add $t2 $t2 $t1
		lw $t0 -8($a0)
		addi $t0 $t0 1
		sw $t0 -8($a0)
		move $v0 $t0
		addi $t0 $t0 -1
		mul $t0 $t0 4
		add $t1 $t1 $t0
Tinsertloop:	lw $t0 -4($t1)
		sw $t0 ($t1)
		addi $t1 $t1 -4
		bne $t1 $t2 Tinsertloop
		sw $a1 ($t2)
		jr $ra
Tpop:
		move $t1 $a0
		lw $t0 -8($a0)
		addi $t0 $t0 -1
		sw $t0 -8($a0)
		mul $t0 $t0 4
		add $t1 $t1 $t0
		lw $v0 ($t1)
		jr $ra
Tput:
		move $t1 $a0
		mul $t0 $a2 4
		add $t1 $t1 $t0
		sw $a1 ($t1)
		jr $ra