.data 0x10020000
inum:   .word 4
data:   .word 5677, 2456, 5432, 653

.data 0x10008000
onum:   .word 4
digit:  .word 0

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
        blt     $t1,$a3, bed   
        div     $t1,$a3
        mflo    $t0              
        add     $t1,$t0,$zero
        blt     $a3,$t0, lp 
bed:        
        add   $v0,$zero,$t1
        sw    $v0,digit($t5)
        add   $t5,$t5,$a2  

        add     $t2,$t2,1
        beq     $t2,$a1, end
        j mkdigit
end:
       
