.data    0x10020000
Q:       .word 5
W:       .word 14, 8, 15, 43, 54
.data    0x10030000
Z:       .word 1                         
X:       .word 0
	 .text
    la   $t0,W      
    li   $t6,4
    lw   $t7,Q
    sw   $t7,Z
    lw   $a0,X
    mul  $t4,$t6,$t7
    sub  $t6,$t4,$t6
    add  $t0,$t0,$t6                                
pp:            
    add  $t1,$zero,$zero 
    la   $a0,W    
secpp:   
    lw   $t3,4($a0)            
    lw   $t2,0($a0)                  
    slt  $t5,$t3,$t2       
    beq  $t5,0,cend   
    add  $t1,$zero,1         
    sw   $t2,4($a0)         
    sw   $t3,0($a0)         
cend:
    addi $a0,$a0,4            
    bne  $a0,$t0,secpp    
    bne  $t1,0,pp
    move $t9,$zero
    move $t2,$zero
lp:
   lw    $t8,W($t9)
   sw    $t8,X($t9)
   add   $t9,$t9,4 
   add   $t2,$t2,1 
   beq   $t2,$t7,end
   j lp
end: 