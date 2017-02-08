.data 0x10020000
B:    .asciiz "."
ten: .double 10

.text
     li $t1, 1
     ldc1 $f10, ten
loadd:
     li $v0, 7
     syscall
load:
     li $v0, 5
     syscall
     move $t2, $v0
     
lp:  beqz $t2,end   
     cvt.w.d $f2 $f0
     mfc1 $t0 $f2
     cvt.d.w $f2 $f2
     li   $v0, 1
     add $a0, $t0, $zero
     syscall
     beq $t1 1 k
     subi $t2, $t2, 1
af:  sub.d $f0 $f0 $f2
     mul.d $f0 $f0, $f10
     j lp
k:
     beqz $t1, lp
     la $a0,B 
     li $v0,4
     syscall
     subi $t1, $t1, 1 
     j af
end:	li $v0 10
	syscall
