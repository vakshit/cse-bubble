.data
arr:        .float  0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434, 0.1126, 0.554, 0.3349, 0.678, 0.3656, 0.9989
p:          .word   12
buckets:
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
.float  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
n:          .word   10
count:      .word   0, 0, 0, 0, 0, 0, 0, 0, 0, 0
new_line:   .asciiz "\n"

.text
.globl main
main:
    la      $s0,            arr
    lw      $s1,            p
    la      $s2,            buckets
    lw      $s3,            n
    la      $s4,            count
    mtc1    $s3,            $f1
    cvt.s.w $f1,            $f1

assign_values:
    li      $t0,            0                   # i = 0
assign_loop:
    beq     $t0,            $s1,        sort_buckets
    mul     $t2,            $t0,        4
    add     $t1,            $s0,        $t2  # t1 contains the i-th element's address
    lwc1    $f2,            ($t1)               # f2 contains the i-th element's value = arr[i]
    mul.s   $f0,            $f2,        $f1
    cvt.w.s $f0,            $f0
    mfc1    $t1,            $f0
    mul     $t3,            $t1,        4
    add     $t5,            $s4,        $t3     # t5 stores the address of count[bucket_index]
    lw      $t4,            0($t5)              # t4 stores value of count[bucket_index]
    mul     $t3,            $t4,        4       # col_idx * element_size
    mul     $t2,            $t1,        48      # row_idx * num_cols * element_size
    add     $t1,            $t2,        $t3     # Final offset
    add     $t2,            $s2,        $t1     # Base address + offset
    s.s     $f2,            0($t2)
    add     $t3,            $t4,        1
    sw      $t3,            0($t5)
    add     $t0,            $t0,        1
    j       assign_loop

sort_buckets:
    li      $t7,            0
sort_loop:
    beq     $t7,            $s3,        merge_buckets
    mul     $t2,            $t7,        48
    add     $s5,            $s2,        $t2
    li      $t0,            1

loop1:
    blt     $t0,            $s3,        continue
    j       exit1
continue:
    mul     $t5,            $t0,        4
    add     $t6,            $t5,        $s5
    lwc1    $f1,            0($t6)              # key = arr[i]
    addi    $t1,            $t0,        -1      # j = i - 1
innerLoop:
    mul     $t2,            $t1,        4
    add     $t6,            $t2,        $s5
    lwc1    $f2,            0($t6)              # f2 = arr[j]
    blt     $t1,            $zero,      outerLoop                                                           # j < 0
    c.lt.s  $f2,            $f1                 # arr[i] <= key
    bc1t    outerLoop
    addi    $t3,            $t2,        4
    add     $t6,            $t3,        $s5
    swc1    $f2,            0($t6)
    addi    $t1,            $t1,        -1
    j       innerLoop
outerLoop:
    mul     $t2,            $t1,        4
    addi    $t3,            $t2,        4
    add     $t6,            $t3,        $s5
    swc1    $f1,            0($t6)
    addi    $t0,            $t0,        1
    j       loop1

exit1:
    li      $t0,            0
    add     $t7,            $t7,        1
    j       sort_loop

merge_buckets:
  la $t0, buckets # pointer for buckets
  la $t1, arr # pointer for arr
  mtc1 $zero, $f3 # f3 = 0.0
  add $t2, $t0, 480 # end address of buckets
  # add $t1 $t1, 4 # end address of arr
  # li $v0, 2
  # mov.s $f12, $f3
  # syscall
  merge_loop:
    beq $t0, $t2, print_values # if arr pointer is at the end, print values
    l.s $f0, 0($t0) # load value from bucket
    c.eq.s $f0, $f3 # check if value is 0
    bc1t zero # if 0, jump to zero
    l.s $f2, 0($t0) # load value from bucket
    swc1 $f2, 0($t1) # store value in arr
    add $t0, $t0, 4
    add $t1, $t1, 4
    j merge_loop 
    zero:
      add $t0, $t0, 4
      j merge_loop
      


print_values:
    li      $t0,            0
print_loop:
    beq     $t0,            48,         exit
    l.s     $f12,           arr($t0)
    li      $v0,            2
    syscall 
    la      $a0,            new_line
    li      $v0,            4
    syscall 
    addi    $t0,            $t0,        4
    j       print_loop

# print1_bucket:
#     li      $v0,            2
#     l.s     $f12,           48($s2)
#     syscall 
#     l.s     $f12,           52($s2)
#     syscall 
#     l.s     $f12,           56($s2)
#     syscall 
#     l.s     $f12,           60($s2)
#     syscall 
#     l.s     $f12,           64($s2)
#     syscall 
#     l.s     $f12,           68($s2)
#     syscall 
#     l.s     $f12,           72($s2)
#     syscall 
#     l.s     $f12,           76($s2)
#     syscall 
#     l.s     $f12,           80($s2)
#     syscall 
#     l.s     $f12,           84($s2)
#     syscall 
#     l.s     $f12,           88($s2)
#     syscall 
#     l.s     $f12,           92($s2)
#     syscall 


exit:
    li      $v0,            10
    syscall 