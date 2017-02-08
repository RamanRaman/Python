.eqv	NEXT	0
.eqv	DATA	4
.data
Action:	.word	'a', append
	.word	'p', pop
	.word	'f', find
	.word	'o', output
	.word	'.', quit
	.word	0,0
List:	.word	0
Junk:	.word	0
.globl main

.macro	push	%r
	addiu	$sp $sp -4
	sw	%r ($sp)
.end_macro

.macro	pop	%r
	lw	%r ($sp)
	addiu	$sp $sp 4
.end_macro

.macro	debug	%s %r
.data
printl:	.asciiz	%s
.text
	push	$v0
	push	$a0

	push	%r
	li	$v0 4
	la	$a0 printl
	syscall
	li	$a0 32
	li	$v0 11
	syscall
	pop	%r
	move	$a0 %r
	li	$v0 34
	syscall
	li	$a0 10
	li	$v0 11
	syscall

	pop	$a0
	pop	$v0
.end_macro

.macro	print	%s
.data
printl:	.asciiz	%s
.text
	li	$v0 4
	la	$a0 printl
	syscall
	li	$a0 10
	li	$v0 11
	syscall
.end_macro

.macro	debug	%s
	push	$v0
	push	$a0
	print	%s
	pop	$a0
	pop	$v0
.end_macro

.text
main:	move	$a0 $zero
	jal	Lcreate
	sw	$v0 List
	jal	Lcreate
	sw	$v0 Junk
	
iloop:	li	$v0 12
	syscall
	blez	$v0 done
	la	$s0 Action
cloop:	lw	$t0 ($s0)
	beqz	$t0 nocmd
	bne	$t0 $v0 cnext
	lw	$t0 4($s0)
	jalr	$t0
	j	iloop
cnext:	addi	$s0 $s0 8
	j	cloop
nocmd:	j	iloop
done:	li	$v0 10
	syscall

pop:	push	$ra
	lw	$a0 List
	jal	Lpop
	debug	"pop" $v0
	pop	$ra
	jr	$ra

append:	push	$ra
	li	$v0 5
	syscall
	debug	"push" $v0
	move	$a1 $v0
	lw	$a0 List
	jal	Lappend
	pop	$ra
	jr	$ra

find:	push	$ra
	li	$v0 5
	syscall
	debug	"find" $v0
	move	$a1 $v0
	lw	$a0 List
	jal	Lfind
	debug	"@" $v0
	pop	$ra
	jr	$ra


dump:	# $a0 — list
dump_loop:
	lw	$a0 NEXT($a0)
	beqz	$a0 dump_fin
	lw	$t0 DATA($a0)
	debug	">" $t0
	j	dump_loop
dump_fin:	
	jr	$ra

output:	debug	"list"
	push	$ra
	lw	$a0 List
	jal	dump
	lw	$a0 Junk
	lw	$t0 NEXT($a0)
	beqz	$t0 outputNJ
	debug	"junk"
	jal	dump
outputNJ:
	pop	$ra
	jr	$ra

quit:	li	$v0 10
	syscall
