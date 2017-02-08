.text
.globl function
function:
    	move $t7 $zero
    	move $k0 $zero
    	move $k1 $zero	
    	li   $t7 4 
    	li   $t8 8        	
    	div  $t6 $t7 $t8 # 0.5	
    	div  $t8 $a0 $t8
    	subi $t8 $t8 2  # количество треугольников
    	move $t7 $zero
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
	    mul $t0 $t0 $t6

	    beq $zero $k1 sred_arifmet
	    blt $t7 $t0 zapis
	    
	    addi $k0 $k0 1         # счетчик цикла
	    beq  $k0 $t8 zap    
sred_arifmet:	    	    	    	     
	    add  $t7 $t7 $t0       # сумма треугольников
	    addi $k0 $k0 1         # счетчик цикла
	    beq  $k0 $t8 end
	    j lp	    
end:
           move  $t9 $zero
           move  $k1 $zero
           li    $t9 1
           div   $t9 $t8  
           mflo  $k1          
           mul   $t7 $t7 $a3     # среднее арифметическое  T 7
           mul   $a2 $a0 $t6
           sub   $a1 $a1 $a0
           move  $a3 $zero
           move  $k0 $zero
           move  $t9 $zero
           li    $t8 0x10030000
           j lp
zapis:
           move $a3 $k0
           sw $a3 ($t8)
           addi $t8 $t8 4
           addi $t9 $t9 24
           move $a3 $zero         
zap:
           move $v0 $t9
           move $v1 $t8
           jr $ra