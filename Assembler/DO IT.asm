.data 0x10020000
inum:   .word 7
data:   .word 654, 756, 585, 7647, 7643, 736, 2345

.data 0x10030000
onum:   .word 0
digit:  .word 0

.text
        la    $a0, data
        lw    $a1, inum
        sw    $a1, onum
        li    $a3, 10
        li    $v1, 1
        li    $t4, 4
        move  $v0, $zero
        move  $t2, $zero
        move  $t3, $zero
        b end 
mkdigit:  
        lw    $at, ($a0)
        add   $a0, $a0, $t4
        add   $t1, $at, $zero
        blt   $t1, $a3, bed        
lp:        
        div   $t1, $a3
        mflo  $t0  
        add   $t1, $t0, $zero
        blt   $a3, $t0, lp 
bed:    
        beq   $t1, $a3, lp    
        add   $v0, $t1, $zero
        sw    $v0, digit ($t3)
        add   $t3, $t3, $t4 
        add   $t2, $t2, $v1
        beq   $t2, $a1 , endr
        j     mkdigit 
endr:
        jr    $ra 
end:
        jal   mkdigit 
        
