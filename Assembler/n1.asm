.text
.globl function
function:
         li   $a2 4
         li   $t3 0x10030000
         move $a3 $zero
         move $t0 $zero
         move $t4 $zero
         move $t6 $zero
begin:
         lw   $t1 ($a1)
         add  $a1 $a1 $a2
         add  $t0 $t0 $t1
         slt  $t4 $t1 $zero  
         add  $a3 $a3 $a2
         beq  $a0 $a3 bren  
         lw   $t1 ($a1)
         slt  $t5 $t1 $zero
         beq  $t4 $t5 begin
         move $t4 $t5  
	 sw $t0 ($t3) 
	 add $t3 $t3 $a2
	 add  $t6 $t6 $a2 
	 move $t0 $zero 
	 j begin 
bren:
         sw $t0 ($t3)
         add  $t6 $t6 $a2
	 li $v1 0x10030000 
	 move $v0 $t6 
	 jr $ra         
