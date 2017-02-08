
.text
.globl function
function:
           li $a2 4
           li $t6 0x10008000  
           li $t3 0x10008004 
           move $a3 $zero
           move $t5 $zero  
lp:
           lw   $at ($a1)
           add  $a1 $a1 $a2
           move $t0 $at 
           add  $t5 $t5 $a2
           blt  $a0 $t5 end    
           beq  $zero $t0 bbo
           blt  $zero $t0 bolshe
menshe:           
           beq  $zero $t2 yy
           move $t4 $t2
           sw   $t4 ($t3)
           add  $t3 $t3 $a2
           add  $a3 $a3 $a2
           move $t2 $zero       
           yy:
               add  $t1 $t1 $t0 
               j lp
bolshe:
           beq  $zero $t1 xx
           move $t4 $t1           
           sw   $t4 ($t3)
           add  $t3 $t3 $a2
           add  $a3 $a3 $a2 
           move $t1 $zero    
           xx:
                add  $t2 $t2 $t0  
                j lp
bbo:
       blt  $zero $t2 menshe
       blt  $t1   $zero bolshe                
end:
       blt  $zero $t2 menshe
       blt  $t1   $zero bolshe
       sw   $a3 ($t6)
       move $v0 $a3
       move $v1 $t4
 
