.data
a:	.word 35
B:      .word 32
C:      .word 254 254 255 256 257 258 259 260
.text
.globl function
function:
	move $v0 $a0
	lw $a0 B
	la $a1 C
	li $t1 2
	li $t6 1
	
	li $a2 0x10008000   # �����
	li $a3 0x10004000
schet:
        move $t4 $zero
        move $t0 $zero
        move $t2 $zero
        move $t7 $zero
        move $t6, $zero
        
        
        lw $t0 ($a1)
        addi $a1 $a1 4  
        addi $k1 $k1 4
        blt  $a0 $k1 end
arif:        	
        div  $t0 $t1
        mflo $t0
        mfhi $t2
        move $t3 $t2
        sw   $t3 ($a3)
        addi $a3 $a3 4
        addi $t4 $t4 1      # ������� �����
        beq  $t0 $zero poi
        j arif
        
poi:
        move $t3 $zero
        addi $a3 $a3 -4  
        lw   $t3 ($a3)
              
        move $t5 $t3
        add  $t4 $t4 -1
        mul  $t7 $t5 1
pii:  
        addi $a3 $a3 -4  
        lw   $t3 ($a3)
        move $t5 $t3 
        mul  $t6 $t6 $t1     # ������� ������
        mul  $t8 $t6 $t5
        add  $t7 $t7 $t8 
        add  $t4 $t4 -1
        beq  $t4 $zero lpp
        j pii
lpp:        
        move $k0 $t7
        sw $k0 ($a2)
	addi $a2 $a2 4
	j schet
end:
        li $v1 0x10008000
        jr $ra
        
