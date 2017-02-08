# Отсюда начинается добавочный код
.text
.globl	main
	# Это код вывода и завершения
	lw	$s1, 0x10030000		# Количество
	sll	$s1, $s1, 2		# …в байтах
	move	$s0, $zero		# индекс
_onext:	bge	$s0, $s1, _ofin		# всё вывели
	lw	$a0, 0x10030004($s0)	# выведем число
	li	$v0, 1
	syscall
	li	$a0, 10			# выведем \n
	li	$v0, 11
	syscall
	addi	$s0, $s0, 4		# следующее число
	j	_onext
_ofin:	li	$v0, 10
	syscall	
main:	# это код старта и ввода
	move	$s0, $zero
	sw	$zero, ($gp)
_inext:	# Ввести число
	li	$v0, 5
	syscall
	lw	$t1, ($gp)		# Проверим, не окончен ли ввод
	bnez	$t1, _ifin		# Если не 0, готово
	sw	$v0, 0x10020004($s0)	# запишем число
	addi	$s0, $s0, 4		# увеличим индекс
	j	_inext
_ifin:	sra	$s0, $s0, 2		# количество введённых чсел
	sw	$s0, 0x10020000		# запишем его
	la	$t1, 0x400000		# Всё! Передаём управление на начало
	jr	$t1
	# Обработка конца ввода
.ktext 0x80000180
	mfc0	$k0, $13		# Причина
	beq	$k0, 0x20, _k_ein	# Если не 0x20
	mfc0	$a0, $14		# Выведем адрес ошибки
	li	$v0, 34
	syscall
	mfc0	$a0, $13		# Выведем причину ошибки
	li	$v0, 34
	syscall
	li	$v0, 10			# Выйдем
	syscall
_k_ein:	sw	$k0, ($gp)		# Положим не 0 в ($gp)
	mfc0	$k0, $14
	addiu	$k0, $k0, 4
	mtc0	$k0, $14
	mtc0	$zero, $13		# Clear Cause register
        mfc0	$k0, $12		# Fix Status register
        andi	$k0, 0xfffd		# Clear EXL bit
        ori	$k0, 0x1		# Enable interrupts
        mtc0	$k0, $12
	eret