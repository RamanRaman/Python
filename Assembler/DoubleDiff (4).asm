.data 0x10020000
        .word 4
a:      .word 3
b:      .word 8
c:      .word 2
d:      .word 7

.data 0x10030000
        .word 2
x:      .word 0
y:      .word 0

.text
        lw      $t1, a
        lw      $t0, b
        lw      $t2, c
        lw      $t3, d   
lp:        
        blt     $t0,$t1,sr
        blt     $t1,$t2,sr2
        blt     $t2,$t3,sr3
        j h    
sr:
        add    $t4,$t0,$t5
        add    $t0,$t1,$t5
        add    $t1,$t4,$t5
        j lp
sr2:
        add    $t4,$t1,$t5
        add    $t1,$t2,$t5
        add    $t2,$t4,$t5
        j lp
sr3:
        add    $t4,$t2,$t5
        add    $t2,$t3,$t5
        add    $t3,$t4,$t5
        j lp
h:
        sub     $t0,$t0,$t1
        sub     $t1,$t2,$t3
        sw      $t0, x
        sw      $t1, y 
