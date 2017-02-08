.text
.globl function
function:
           li $a2 4
           li $v0 4
           li $t6 0x10030004
           move $t5 $t6 
           li   $t1 10
           move $t3  $zero
           move $t4  $zero
           move $t5  $zero   
lp:
	   lw      $at ($a1)
           add     $a1 $a1 $a2
           move    $t0 $at
           add     $t4  $t4  $a2
           blt     $a0  $t4, end
           blt     $zero $t0 k
           mul     $t0 $t0 -1    
k:
           div     $t0 $t1
           mflo    $t0
           mfhi    $t2
           add     $t3 $t3 $t2
           beq     $t0 $zero p
           j k
p: 
	   blt     $t5  $t3 iyu
	   move    $t3  $zero
	   j lp
iyu:
	   move $t5  $t3
	   move    $t3  $zero
	   j lp
end:        
           sw  $t5 ($t6)
           move $v1 $t5
           move $t2 $zero
	   li $t2 0x10030000
	   sw  $v0 ($t2)
	   jr   $ra
	   
