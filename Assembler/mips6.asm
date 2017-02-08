.data 0x10020000
A:         .word 5
B:     .word 1,3,5,6,7


.data 0x10030000
T:     .word 1
X:      .word 0 

.text
        la  $t0, B
        lw  $t4, A
        li  $t1,4
        li  $t7,-4
        mul $t6,$t1,$t4
	sub $t6,$t6,$t1
	add $t0, $t0, $t6
	move $t9,$zero
	move $s0,$zero
secc:
	lw $t2, ($t0)
	add $t0,$t0,$t7
	andi $t3,$t2,1
	beqz $t3,loop
	
	add $t8,$t8,1
        beq $t8,$t4,End
	
	j secc
loop:
	add $t5, $t2,$zero
	sw  $t5,X($t9)
	add $s0,$s0,1
	add $t9,$t9,$t1
	
	add $t8,$t8,1
        beq $t8,$t4,End
	
	j secc     
End:
	sw $s0,T
