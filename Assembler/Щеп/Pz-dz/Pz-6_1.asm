#������ � ��������� �������
	.data 
A:	.byte 14, 15 ,117, 19, 18                             #��������� ������� ���������� ����� ������ ��������� ����� 
B:	.byte 13
C:	.byte 0
#����� ����� ����������� ���������� ����������
	.text 
#����� ����� ����������� �������� �������� � ����������� ���������
main:	#��������� ����� ����������� � ���� �����
	la $t0,A         #��������� ����� ������� � �������
	lb $t1,B         #��������� ���� �����, ������� ����� ���������
	lb $t5,C         #������� ������ ������� ���� ����� ���������� ���������
	lbu $at,($t0)    #��������� ������ �������
	addiu $t0,$t0,1  #���������� ��������� �� �������
	slt $t2,$t1,$at  #���������, �������� �� ���� ������� ������ �������.
	add $t3,$t2,0    #� ������� $t3 �������� ����� $t2,0
	
	lbu $at,($t0)    #��������� ������ �������
	addiu $t0,$t0,1  #���������� ��������� �� �������
	slt $t2,$t1,$at  #���������, �������� �� ���� ������� ������ �������.
	addu $t4,$t3,$t2 #� ������� $t4 �������� ����� $t3,$t2
	
	lbu $at,($t0)    #��������� ������ �������
	addiu $t0,$t0,1  #���������� ��������� �� �������
	slt $t2,$t1,$at  #���������, �������� �� ���� ������� ������ �������.
	addu $t3,$t4,$t2 #� ������� $t3 �������� ����� $t4,$t2
	
	lbu $at,($t0)    #��������� ��������� �������
	addiu $t0,$t0,1  #���������� ��������� �� �������
	slt $t2,$t1,$at  #���������, �������� �� ���� ������� ������ �������.
	addu $t4,$t3,$t2 #� ������� $t4 �������� ����� $t3,$t2
	
	lbu $at,($t0)    #��������� ����� �������
	addiu $t0,$t0,1  #���������� ��������� �� �������
	slt $t2,$t1,$at  #���������, �������� �� ���� ������� ������ �������.
	addu $t3,$t4,$t2 #� ������� $t3 �������� ����� $t4,$t2
	
	addu $t5,$t3,0   #� ������� $t5 �������� ����� $t3,0
	sb $t5,C         #������� ���������� ����� ������ ��������� ����� 
#����� ����� ����������� ������� 
	addiu $v0,$zero,10  # �������� ������ ���������� ������ (10 - �����)
	syscall             # ��������� �����
