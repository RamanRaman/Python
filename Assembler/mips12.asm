.text
	li $t1, 10
	move $t2, $sp
lo:	
	li $v0, 5 
	syscall
	move $t0, $v0
	sw $t0, ($sp)
	subi $sp $sp 4
	subi $t1, $t1 1
	beqz $t1, end
        j lo
end:
        move $sp, $t2
        li $t1, 10
out:    lw $a0, ($sp)
        li $v0 1
        syscall
        subi $sp, $sp, 4
        subi $t1, $t1, 1       
        li  $a0 '\n'
        li  $v0 11
        syscall
        bnez $t1, out
	b q
desig:
	.ktext 0x80000180 
	eret
q:      