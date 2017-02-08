.data 0x10020000
inum:   .word 4
data:   .word 1234, 234534, 78, 2

.data 0x10030000
onum:   .word 4
digit:  .word 1, 2, 7 ,2

.text

        la    $a0, data
        lw    $a1, inum
        li    $a2,4
        li    $a3,10
        move  $v0 $zero
        jal   mkdigit     
         
mkdigit:
        
        lw    $at,($a0)
        add   $a0,$a0,$a2
        add   $t1,$at,$zero
lp:        
        div     $t1,$a3
        mflo    $t0              # целое
        add     $t1,$t0,$zero
        blt     $a3,$t0, lp 
        
        add   $t4,$zero,$t1
        sw    $t4,digit($t5)
        add   $t5,$t5,$a2  

        add     $t2,$t2,1
        beq     $t2,$a1, end
       j mkdigit
end:
       jr     $ra                # конец