
.text
.globl function
function:
    	move $t7 $zero
    	move $k0 $zero
    	move $k1 $zero	
    	li   $t7 4 
    	li   $t8 8        	
    	li   $t6 2	
    	div  $t8 $a0 $t8
    	subi $t8 $t8 2  # количество треугольников
    	move $t7 $zero
    	move $a2 $a1
lp:        
        lw $t0 ($a1)    #x1
        lw $t1 4($a1)	#y1
        	
        lw $t2 8($a1)	#x2
        lw $t3 12($a1)	#y2
        
        lw $t4 16($a1)	#x3
        lw $t5 20($a1)	#y3
        
        addi $a1 $a1 8
ploshadi:
	    sub $t0 $t0 $t4
	    sub $t3 $t3 $t5
	    mul $t0 $t0 $t3
	    
	    sub $t2 $t2 $t4
	    sub $t1 $t1 $t5
	    mul $t1 $t1 $t2
	    
	    sub $t0 $t0 $t1
	    div $t0 $t0 $t6
	    abs $t0 $t0

	    beq $zero $k1 sred_arifmet
	    addi $k0 $k0 1         # счетчик цикла
	    blt $t7 $t0 zapis
	    
	    
	    beq  $k0 $t8 zap 
	    j lp   
sred_arifmet:	    	    	    	     
	    add  $t7 $t7 $t0       # сумма треугольников
	    addi $k0 $k0 1         # счетчик цикла
	    beq  $k0 $t8 end
	    j lp	    
end:
           move  $t9 $zero
           move  $k1 $zero
           div   $t7 $t8  
           mflo  $t7                    # среднее арифметическое  T 7
           move  $a3 $zero
           move  $k0 $zero
           move  $a1 $a2
           li    $k1 0x10030000
           j lp
zapis:
           move $a3 $k0
           sw $a3 ($k1)
           addi $k1 $k1 4
           addi $t9 $t9 24
           move $a3 $zero
           j lp         
zap:
           move $v0 $t9
           move $v1 $k1
           jr $ra
