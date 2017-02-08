.data 0x10020000
        .word 1
a:      .word 180

.data 0x10030000
        .word 1
x:      .word 0

.text
      lw      $t0, a
      blt     $t4,$t0,k
      mul     $t0,$t0,-1   
k:
      addu    $t1,$t1,10
      div     $t0,$t1
      mflo    $t0
      mfhi    $t2
      add     $t3,$t3,$t2
      beq     $t0,$t4,p
      j k
p:
      sw      $t3, x