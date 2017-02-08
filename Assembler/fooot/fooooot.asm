.globl main
.data
error:	.asciiz "Error: $fp or $s* registers is changed"
serror:	.asciiz "Error: stack smash"
.text
main:	li	$s1 11		# ������ �������� $s
	li	$s2 22
	li	$s3 33
	li	$s4 44
	li	$s5 55
	li	$s6 66
	li	$s7 77
	li	$fp 88
	
	move	$s0 $sp		# ���� �� �����
	sw	$zero ($gp)	# ���� ����� �����
innxt:	li	$v0 5		# ����� ��������� �����
	syscall
	lw	$t0 ($gp)	
	bnez	$t0 infin	# ���� �������
	addi	$sp $sp -4
	sw	$v0 ($sp)	# ��������� �����
	b	innxt
infin:	sub	$a0 $s0 $sp	# ������� ������ ����
	li	$v0 9		# ������� �
	syscall
	add	$t0 $v0 $a0	# ��������� �� �����
movnxt:	sub	$t0 $t0 4	# ������ ����
	bltu	$t0 $v0 movfin	# �� ����������
	lw	$t1 ($sp)	# ������ ��������� ����
	addi	$sp $sp 4
	sw	$t1 ($t0)	# � ������� � ������
	b 	movnxt
movfin: li	$t0 20		# ������ �������� $t
	li	$t1 21
	li	$t2 22
	li	$t3 23
	li	$t4 24
	li	$t5 25
	li	$t6 26
	li	$t7 27
	li	$t8 28
	li	$t9 29
	move	$a1 $v0		# $a0 � ������, $a1 � �����
	jal	function	# ����� �������
	move	$t0 $v0		# ���������� ������ � ������
	move	$t1 $v1		# ���� �����
	addu	$t0 $t1 $t0	# ������� ������
outnxt:	bgeu	$t1 $t0	outfin	# �� ������
	lw	$a0 ($t1)	# ������� ��������� �����
	li	$v0 1
	syscall
	li	$a0 10		# ������� ������� ������
	li	$v0 11
	syscall
	addiu	$t1 $t1 4	# ������� �������
	b 	outnxt
outfin:	subu	$t0 $sp $s0	# �������� ����������� �����
	beqz	$t0 nosmsh
	la	$a0 serror
	b	doerr
nosmsh:	addu	$t0 $t0 $s1	# ����������� ���������
	addu	$t0 $t0 $s2
	addu	$t0 $t0 $s3
	addu	$t0 $t0 $s4
	addu	$t0 $t0 $s5
	addu	$t0 $t0 $s6
	addu	$t0 $t0 $s7
	addu	$t0 $t0 $fp
	beq	$t0 396 regok
	la	$a0 error
doerr:	li	$v0 4
	syscall
	li	$a0 1
	li	$v0 17
	syscall
regok:	li	$v0 10
	syscall
.kdata
kerror:	.asciiz	"Error "
address:.asciiz	" at "
	
.ktext 0x80000180
	mfc0	$k0 $13		# �������
	beq	$k0 0x20 ein	# ���� �� 0x20
	li	$v0 4
	la	$a0 kerror
	syscall
	mfc0	$a0 $13		# ������� ������� ������
	li	$v0 34
	syscall
	li	$v0 4
	la	$a0 address
	syscall
	mfc0	$a0 $14		# ������� ����� ������
	li	$v0 34
	syscall
	li	$v0 10		# ������
	syscall
ein:	sw	$k0 ($gp)	# ������� �� 0 � ($gp)
	mfc0	$k0 $14
	addiu	$k0 $k0 4
	mtc0	$k0 $14
	mtc0	$zero $13	# Clear Cause register
        mfc0	$k0 $12		# Fix Status register
        andi	$k0 0xfffd	# Clear EXL bit
        ori	$k0 0x1		# Enable interrupts
        mtc0	$k0 $12
	eret