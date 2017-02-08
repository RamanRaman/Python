.data 0x10020000
B:    .ascii "."
desyat:  .double 10
.data 0x10008000
onum:   .word 0

.text
     li   $t1, 1
     lwc1 $f3, desyat
loadd:
     li $v0, 7
     syscall
load:
     li $v0, 12
     syscall
     move $t2, $v0
     
lp:     
     cvt.w.d $f2 $f0
     mfc1 $t0 $f2
     li   $v0, 1
     add $a0, $t0, $zero
     syscall
     j k
lop:     
     sub.d $f0 $f0 $f2
     mul.d $f0 $f0, $f3
     subi $t2, $t2, 1
     beqz $t2,end
     j lp
     
k:
     beqz $t1, lp
     la $a0,B 
     li $v0,4
     syscall
     subi $t1, $t1, 1 
     j lop
end:
