.data 0x10020000
inum:   .word 1
A:   .word 456

.data 0x10008000
onum:   .word 1
g:      .word 0
.text
lp:	
	lw $t0, A
	j  gr
gr:	
	lw $t3, ($t0)
	divu $t3,$t3,10
	mfhi $t1
	beqz $t1,end
	j gr
	

end:
	sw $t3,g