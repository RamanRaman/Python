.data
xone:	.float -20.1
yone:	.float 36.22
xtwo:	.float 92.6
ytwo:	.float -100.6
xthree:	.float 39.01
ythree:	.float 18.232
xfour:	.float -84.78
yfour:	.float -51.5
.text
	l.s $f0, xone
	l.s $f1, yone
	l.s $f2, xtwo
	l.s $f3, ytwo
	l.s $f4, xthree
	l.s $f5, ythree
	l.s $f6, xfour
	l.s $f7, yfour
	sub.s $f8, $f3, $f1
	sub.s $f9, $f0, $f2
	sub.s $f10, $f1, $f3
	mul.s $f10, $f0, $f10
	sub.s $f11, $f2, $f0
	mul.s $f11, $f1, $f11
	add.s $f12, $f10, $f11
	sub.s $f10, $f10, $f10
	sub.s $f11, $f11, $f11
	sub.s $f13, $f7, $f5
	sub.s $f14, $f4, $f6
	sub.s $f10, $f5, $f7
	mul.s $f10, $f4, $f10
	sub.s $f11, $f6, $f4
	mul.s $f11, $f5, $f11
	add.s $f15, $f10, $f11	
	sub.s $f10, $f10, $f10
	sub.s $f11, $f11, $f11
matrixD:
	mul.s $f16, $f8, $f14
	mul.s $f17, $f9, $f13
	sub.s $f18, $f16, $f17
matrixDcone:
	sub.s $f16, $f16, $f16
	sub.s $f17, $f17, $f17
	mul.s $f16, $f9, $f15
	mul.s $f17, $f12, $f14
	sub.s $f19, $f16, $f17
matrixDctwo:
	sub.s $f16, $f16, $f16
	sub.s $f17, $f17, $f17
	mul.s $f16, $f13, $f12
	mul.s $f17, $f8, $f15
	sub.s $f20, $f16, $f17
x:
	div.s $f21, $f19, $f18
y:	
	div.s $f21, $f20, $f18
	