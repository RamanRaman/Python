.data 0x10020000
        .word 1
a:      .word 05

.data 0x10030000
        .word 1
x:      .word 0

.text
      lw      $t0, a
      addu    $t1,$t1,10
      blt     $t4,$t0,k
      mul     $t0,$t0,-1   
k:
      div     $t0,$t1
      mflo    $t0
      mfhi    $t2
      beq     $t2,$t4,k
      add     $t3,$t3,$t2
      beq     $t0,$t4,p
      j k
p:
      sw      $t3, x
