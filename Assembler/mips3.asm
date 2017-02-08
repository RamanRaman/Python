.data 0x10020000
        .word 1
A:      .word 0045

.data 0x10030000
        .word 1
X:      .word 0

.text
      lw      $t0,A
      li      $t1,10
      blt     $zero,$t0,lp
      mul     $t0,$t0,-1   
lp:
      div     $t0,$t1
      mflo    $t0
      mfhi    $t2
      add     $a0,$a0,$t2
      beq     $t0,$zero,end
      j lp
end:
      sw      $a0,X
