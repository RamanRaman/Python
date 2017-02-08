.data 0x10020000
        .word 4                         # Количество слов
a:      .word 12                        # Входные данные
b:      .word 13
c:      .word 14
d:      .word 15

.data 0x10030000
        .word 2                         # количество слов
x:      .word 0                         # выходные данные
y:      .word 0

.text
        lw      $t1, a
        lw      $t0, b
        lw      $t2, c
        lw      $t3, d
        addu    $t0,$t1,$t0
        addu    $t1,$t2,$t3
        sw      $t0, x
        sw      $t1, y