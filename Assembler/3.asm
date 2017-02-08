.data 0x10020000
width: 		.float 512
height:		.float 256
a: 		.float 1.04725
B: 		.float 8.34251
c: 		.byte 4
x0: 		.float -2.10514
x1: 		.float 3.71027
y0: 		.float -2.36443
y1: 		.float 2.78315
.data 0x10030000
out:		 .word 0
.text
	lwc1 $f0 width
	lwc1 $f1 x0
	lwc1 $f2 y0
	lwc1 $f3 x1
	lwc1 $f4 y1
	lwc1 $f5 a
	lwc1 $f6 B
	li $t0 256
	li $t1 512
	sub.s $f3 $f3 $f1 
	sub.s $f4 $f4 $f2 
	div.s $f3 $f3 $f0
	lwc1 $f0 height
	div.s $f4 $f4 $f0
	la $t5 out
exit:
