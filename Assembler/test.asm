# ������ ���������� ���������� ���
.text
.globl	main
	# ��� ��� ������ � ����������
	lw	$s1, 0x10030000		# ����������
	sll	$s1, $s1, 2		# �� ������
	move	$s0, $zero		# ������
_onext:	bge	$s0, $s1, _ofin		# �� ������
	lw	$a0, 0x10030004($s0)	# ������� �����
	li	$v0, 1
	syscall
	li	$a0, 10			# ������� \n
	li	$v0, 11
	syscall
	addi	$s0, $s0, 4		# ��������� �����
	j	_onext
_ofin:	li	$v0, 10
	syscall	
main:	# ��� ��� ������ � �����
	move	$s0, $zero
	sw	$zero, ($gp)
_inext:	# ������ �����
	li	$v0, 5
	syscall
	lw	$t1, ($gp)		# ��������, �� ������� �� ����
	bnez	$t1, _ifin		# ���� �� 0, ������
	sw	$v0, 0x10020004($s0)	# ������� �����
	addi	$s0, $s0, 4		# �������� ������
	j	_inext
_ifin:	sra	$s0, $s0, 2		# ���������� �������� ����
	sw	$s0, 0x10020000		# ������� ���
	la	$t1, 0x400000		# ��! ������� ���������� �� ������
	jr	$t1
	# ��������� ����� �����
.ktext 0x80000180
	mfc0	$k0, $13		# �������
	beq	$k0, 0x20, _k_ein	# ���� �� 0x20
	mfc0	$a0, $14		# ������� ����� ������
	li	$v0, 34
	syscall
	mfc0	$a0, $13		# ������� ������� ������
	li	$v0, 34
	syscall
	li	$v0, 10			# ������
	syscall
_k_ein:	sw	$k0, ($gp)		# ������� �� 0 � ($gp)
	mfc0	$k0, $14
	addiu	$k0, $k0, 4
	mtc0	$k0, $14
	mtc0	$zero, $13		# Clear Cause register
        mfc0	$k0, $12		# Fix Status register
        andi	$k0, 0xfffd		# Clear EXL bit
        ori	$k0, 0x1		# Enable interrupts
        mtc0	$k0, $12
	eret