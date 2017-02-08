.data
matrix: .byte 1  2  3  4  5
              6  7  8  9  10
              0  12 13 14 15
              16 17 18 19 20
str: .byte 4
stlb: .byte 5
n_stlb: .byte 1
rez: .byte 0
.text
main: 
       move $t1,$zero     #
       la $t2, matrix     #
       lb $t3, str        #
       lb $t4, stlb       #
       lb $t5, n_stlb     #
       addi $t6, $zero, 1 #
       lbu $t7, ($t2)     #
       mulu $t6,$t6,$t4   #
loop:	
       bgt $t1,$t4,halt
       add $t2,$t2,$t6
       add $t1,$t1,1
       lbu $at,($t2)
       bgt $at,$t7,loop
       move $t7,$at
       b loop
halt: 
       sb $t7, rez
       addiu $v0,$zero,10
       syscall
