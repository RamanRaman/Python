.data 0x10020000
inum:   .word 5
data:   .word 1234, 234534, 78, 2, 655

.data 0x10030000
onum:   .word 5
digit:  .word 0

.text

        la    $a0, data
        lw    $a1, inum
        li    $a2,4
        li    $a3,10
        move  $v0 $zero
        move  $v1 $zero
        b     mkdigit  
          
         
mkdigit:
        
        lw    $at,($a0)
        add   $a0,$a0,$a2
        add   $t1,$at,$zero
lp:     
        blt   $t1,$a3, bed   
        div   $t1,$a3
        mflo  $t0              # �����
        add   $t1,$t0,$zero
        blt   $a3,$t0, lp 
bed:        
        add   $v0,$zero,$t1
        sw    $v0,digit($t5)
        add   $t5,$t5,$a2  

        add   $t2,$t2,1
        beq   $t2,$a1, end
        jr     $ra
end: