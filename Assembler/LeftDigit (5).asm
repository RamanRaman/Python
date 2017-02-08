.data 0x10020000
inum:   .word 7
data:   .word -1234, 234534, 78, 30, 50, -42

.data 0x10030000
onum:   .word 0
digit:  .word 0

.text
        la    $a0, data
        lw    $a1, inum
        li    $a2,4
        li    $a3,10
        li    $t7,1
        li    $t8,-1
        move  $v0 $zero
        move  $v1 $zero
        move  $t2 $zero
        b end
endr:
        jr    $ra  
mkdigit:  
        lw    $at,($a0)
        add   $a0,$a0,$a2
        add   $t1,$at,$zero
        blt   $zero,$t1,lp
        mul   $t1,$t1,$t8
lp:      
        blt   $t1,$a3, bed  
        div   $t1,$a3
        mflo  $t0              
        add   $t1,$t0,$zero
        blt   $a3,$t0, lp 
bed:        
        beq   $t1,$zero,bur
        add   $v0,$zero,$t1
        sw    $v0,digit($t5)
        add   $t5,$t5,$a2
        add   $v1,$v1,$t7
bur:  
        add   $t2,$t2,$t7
        beq   $t2,$a1, endr
        j     mkdigit  
end:
        jal   mkdigit 
        sw    $v1,onum
        
