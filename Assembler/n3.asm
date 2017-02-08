.data 0x10020000
inum:   .word 7
data:   .double 6.67548757656
B:	.asciiz "."

.data 0x10008000
onum:   .word 0

.text
     ld $t0, data
     lw $t6, inum
     j k
k:
     mul $t0,$t0,10
     subi $t6,$t6,1
     beqz $t6, end 
     j k 
end:
     sw $t0, onum
     li $a0 '\n'
     li $v0 11
     syscall
