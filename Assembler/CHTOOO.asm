.text
	li $t1, 10
lo:	
	li $v0 5 
	syscall
	move $t0, $v0
lp:
	sw $t0 ($sp)
	subi $sp $sp 4
	subi $t1, $t1 1
	beqz $t1, end
        j lo
end:
	li $v0 10
	syscall
desig:
	.ktext 0x80000180 
	eret
