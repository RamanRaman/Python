.data 0x10020000
        .word 1
a:      .word 0083

.data 0x10030000
        .word 1
x:      .word 0

.text
      lw      $t0,a
      li      $t1,10
      blt     $zero,$t0,topka
      mul     $t0,$t0,-1   
topka:
      div     $t0,$t1
      mflo    $t0
      mfhi    $t2
      add     $a0,$a0,$t2
      beq     $t0,$zero,call
      j topka
call:
      sw      $a0,x
