.data 0x10020000
        .word 4
                                       
a:      .word 3                        
b:      .word 7
c:      .word 2
d:      .word 8

.data 0x10030000
        .word 2  
                                        
x:      .word 0                        
y:      .word 0

.text
        lw      $t0, a
        lw      $t1, b
        lw      $t2, c
        lw      $t3, d

        blt     $t0,$t1,l
        addu    $t5,$t1,0
        
        blt     $t2,$t3,z
        addu    $t6,$t2,0
        j v
l:
        addu    $t5,$t1,0
        blt     $t2,$t3,z
        addu    $t6,$t2,0
        j v
z:        
        addu    $t6,$t3,0 
        j v
        
v: 
       blt     $t5,$t6,n
       addu    $a0,$t5,0
n:
       addu    $a0,$t6,0
       
        