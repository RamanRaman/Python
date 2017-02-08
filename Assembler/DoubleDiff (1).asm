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
        lw      $t5,a
        
        blt     $t2,$t3,z
        lw      $t6,c
        j v
l:
        lw      $t5,b
        blt     $t2,$t3,z
        lw      $t6,c
        j v
z:        
        lw      $t6,d 
        j v
        
v:
        
        sw      $t0, x
        sw      $t1, y
        