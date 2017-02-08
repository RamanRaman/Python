.data
xone:	.float -20.1
yone:	.float 36.22
xtwo:	.float 92.6
ytwo:	.float -100.6
xthree:	.float 39.01
ythree:	.float 18.232
xfour:	.float -84.78
yfour:	.float -51.5
u:	.float 0
v:	.float 0
.text
registers:
	
	l.s $f0, xone
	l.s $f2, yone
	l.s $f4, xtwo
	l.s $f6, ytwo
	l.s $f8, xthree
	l.s $f10, ythree
	l.s $f12, xfour
	l.s $f14, yfour
cvtt:
	cvt.d.s $f0,$f0
	cvt.d.s $f2,$f2
	cvt.d.s $f4,$f4
	cvt.d.s $f6,$f6
	cvt.d.s $f8,$f8
	cvt.d.s $f10,$f10
	cvt.d.s $f12,$f12
	cvt.d.s $f14,$f14
aone:
	sub.d $f16, $f6, $f2
bone:
	sub.d $f18, $f0, $f4
cone:
	sub.d $f20, $f2, $f6
	mul.d $f26, $f0, $f20
	sub.d $f22, $f4, $f0
	mul.d $f28, $f2, $f22
	add.d $f24, $f26, $f28
atwo:
	sub.d $f20, $f20, $f20
	sub.d $f22, $f22, $f22
	sub.d $f26, $f14, $f10
btwo:
	sub.d $f28, $f8, $f12
ctwo:
	sub.d $f20, $f10, $f14
	mul.d $f20, $f8, $f20
	sub.d $f22, $f12, $f8
	mul.d $f22, $f10, $f22
	add.d $f30, $f20, $f22	
	sub.d $f20, $f20, $f20
	sub.d $f22, $f22, $f22
null:
	sub.d $f0, $f0, $f0
	sub.d $f2, $f2, $f2
	sub.d $f4, $f4, $f4
	sub.d $f6, $f6, $f6
	sub.d $f8, $f8, $f8
	sub.d $f10, $f10, $f10
	sub.d $f12, $f12, $f12
	sub.d $f14, $f14, $f14
matrixD:
	mul.d $f0, $f16, $f28
	mul.d $f2, $f18, $f26
	sub.d $f4, $f0, $f2
matrixDcone:
	sub.d $f0, $f0, $f0
	sub.d $f2, $f2, $f2
	mul.d $f0, $f18, $f30
	mul.d $f2, $f28, $f24
	sub.d $f6, $f0, $f2
matrixDctwo:
	sub.d $f0, $f0, $f0
	sub.d $f2, $f2, $f2
	mul.d $f0, $f26, $f24
	mul.d $f2, $f16, $f30
	sub.d $f8, $f0, $f2
x:
	div.d $f10, $f6, $f4
y:	
	div.d $f12, $f8, $f4
save:
	cvt.s.d $f10,$f10
	cvt.s.d $f12,$f12
	s.d $f10,u
	s.d $f12,v
