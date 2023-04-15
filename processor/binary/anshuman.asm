ori     $s7,    $zero,  0x1                 # load first address of array
ori     $s0,    $zero,  0x0
ori     $t0,    $zero,  0x0
lw      $s6,    0x0,    $t0                 # load size of array
subi    $s6,    $s6,    
ori     $s1,    $zero,  0x0
add     $t7,    $s7,    $s1
lw      $t0,    0x0,    $t7
lw      $t1,    0x4,    $t7
slt     $t2,    $t0,    $t1
bne     $t2,    $zero,  0xf
sw      $t1,    0x0,    $t7
sw      $t0,    0x4,    $t7
addi    $s1,    $s1,    0x1
sub     $s5,    $s6,    $s0
bne     $s1,    $s5,    0x7
addi    $s0,    $s0,    0x1
ori     $s1,    $zero,  0x0
bne     $s0,    $s6,    0x7