.text
.globl function
function:
           li $t7 1
           li $t6 0x10030000
           li   $t1 10
           move $t3 $zero
           move $t4 $zero
           move $t2 $zero
           move $t8 $zero
start:
	   move $t0 $zero
	   lw      $t0 ($a1)
           addi     $a1 $a1 4
           addi     $t4  $t4 4
           blt     $a0  $t4 end
           blt     $zero $t0 str
           mul     $t0 $t0 -1    
str:
           div     $t0 $t1
           mflo    $t0
           mfhi    $t2
           add     $t3 $t3 $t2
           beq     $t0 $zero red
           j str
red: 
	   blt     $t8  $t3 moved
	   move    $t3  $zero
	   j start
moved:
	   move $t8  $t3
	   move $t3  $zero
	   j start
end:       
           sw  $t8 ($t6)
	   move $v0 $t7
	   move $v1 $t6
	   jr $ra
