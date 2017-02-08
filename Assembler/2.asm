.data 0x10020000
        .word 4
a:      .word 1
b:      .word 2
c:      .word 3
d:      .word 4

.data 0x10030000
        .word 2
x:      .word 0
y:      .word 0

.text
        lw      $t1, a
        lw      $t0, b
        lw      $t2, c
        lw      $t3, d 
        addu    $v0,$v0,2
        blt     $t0,$t1,l
        addu    $t5,$t0,0
        addu    $t7,$t1,0
        blt     $t2,$t3,z
        addu    $t6,$t2,0
        addu    $t8,$t3,0 
        j v
l:
        addu    $t5,$t1,0
        addu    $t7,$t0,0
        blt     $t2,$t3,z
        addu    $t6,$t2,0
        addu    $t8,$t3,0
        j v
z:        
        addu    $t6,$t3,0
        addu    $t8,$t2,0 
        j v      
v: 
        blt     $t5,$t6,n
        addu    $a0,$t5,0
        blt     $t7,$t8,m
        addu    $a1,$t8,0
        j end
n:
        addu    $a0,$t6,0
        blt     $t7,$t8,m
        addu    $a1,$t8,0
        j end
m:
        addu    $a1,$t7,0
        j end
end:
        seq     $s0,$a1,$t1
        seq     $s1,$a0,$t2
        add     $s0,$s0,$s1
        beq     $s0,$v0,cc
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t2
        seq     $s1,$a0,$t1
        add     $s0,$s0,$s1
        beq     $s0,$v0,cc
        move    $s0,$zero
        move    $s1,$zero 
        seq     $s0,$a1,$t0
        seq     $s1,$a0,$t1
        add     $s0,$s0,$s1
        beq     $s0,$v0,ccc
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t1
        seq     $s1,$a0,$t0
        add     $s0,$s0,$s1
        beq     $s0,$v0,ccc
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t0
        seq     $s1,$a0,$t2
        add     $s0,$s0,$s1
        beq     $s0,$v0,cos
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t2
        seq     $s1,$a0,$t0
        add     $s0,$s0,$s1
        beq     $s0,$v0,cos
        move    $s0,$zero
        move    $s1,$zero 
        seq     $s0,$a1,$t0
        seq     $s1,$a0,$t3
        add     $s0,$s0,$s1
        beq     $s0,$v0,cosu
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t3
        seq     $s1,$a0,$t0
        add     $s0,$s0,$s1
        beq     $s0,$v0,cosu
        move    $s0,$zero
        move    $s1,$zero 
        seq     $s0,$a1,$t1
        seq     $s1,$a0,$t3
        add     $s0,$s0,$s1
        beq     $s0,$v0,cox
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t3
        seq     $s1,$a0,$t1
        add     $s0,$s0,$s1
        beq     $s0,$v0,cox
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t2
        seq     $s1,$a0,$t3
        add     $s0,$s0,$s1
        beq     $s0,$v0,coxi
        move    $s0,$zero
        move    $s1,$zero
        seq     $s0,$a1,$t3
        seq     $s1,$a0,$t2
        add     $s0,$s0,$s1
        beq     $s0,$v0,coxi
        move    $s0,$zero
        move    $s1,$zero 
coxi:
        blt    $t0,$t1,nobz
        addu   $a2,$t1,0
        addu   $a3,$t0,0
        j vx
nobz:
        addu   $a2,$t0,0
        addu   $a3,$t1,0 
        j vx         
cox:
        blt    $t0,$t2,nobzi
        addu   $a2,$t2,0
        addu   $a3,$t0,0
        j vx
nobzi:
        addu   $a2,$t0,0
        addu   $a3,$t2,0 
        j vx                 
cosu:
        blt    $t1,$t2,nozi
        addu   $a2,$t2,0
        addu   $a3,$t1,0
        j vx
nozi:
        addu   $a2,$t1,0
        addu   $a3,$t2,0 
        j vx                
cos:
        blt    $t1,$t3,noz
        addu   $a2,$t3,0
        addu   $a3,$t1,0
        j vx
noz:
        addu   $a2,$t1,0
        addu   $a3,$t3,0 
        j vx                        
cc:
        blt    $t0,$t3,nz
        addu   $a2,$t3,0
        addu   $a3,$t0,0
        j vx
nz:
        addu   $a2,$t0,0
        addu   $a3,$t3,0 
        j vx        
ccc:
        blt    $t2,$t3,nzz
        addu   $a2,$t3,0
        addu   $a3,$t2,0
        j vx
nzz:
        addu   $a2,$t2,0
        addu   $a3,$t3,0  
        j vx                   
vx:  
        move    $t0,$zero
        move    $t1,$zero
        sub     $t0,$a0,$a3
        sub     $t1,$a2,$a1
        
        
