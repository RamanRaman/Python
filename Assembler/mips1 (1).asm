.data   
A: .word 16
B: .word 1,2,3,-4
.text
.globl function
function:
         
           lw $a0 A
           la $a1 B
           li $a2 4
           li $s6 0x10008000  
           li $s3 0x10008004 
           move $a3 $zero
           move $s5 $zero  
lp:
           lw   $at ($a1)
           add  $a1 $a1 $a2
           move $s0 $at 
           add  $s5 $s5 $a2
           blt  $a0 $s5 end    
           beq  $zero $s0 lp
           blt  $zero $s0 bolshe
menshe:           
           beq  $zero $s2 yy
           move $s4 $s2
           sw   $s4 ($s3)
           add  $s3 $s3 $a2
           add  $a3 $a3 $a2
           move $s2 $zero       
           yy:
               add  $s1 $s1 $s0 
               j lp
bolshe:
           beq  $zero $s1 xx
           move $s4 $s1
           sw   $s4 ($s3)
           add  $s3 $s3 $a2
           add  $a3 $a3 $a2 
           move $s1 $zero    
           xx:
                add  $s2 $s2 $s0  
                j lp
end:
       blt  $zero $s2 menshe
       blt  $s1   $zero bolshe
       sw   $a3 ($s6)
       move $v0 $a3
       move $v1 $s4
       jr   $ra  
