.data

arr: .word 6, 2, 7, 1, 9, 4
n: .word 6
new_line: .asciiz "\n"

.text
.globl main


print_array:
    addi    $sp,                $sp,        -4
    sw      $ra,                0($sp)
    add     $t7,                $zero,      $zero

loop:
    bge     $t7,                $t0,        return
    li      $v0,                1
    sll     $t8,                $t7,        2
    add     $t8,                $t8,        $a1
    lw      $a0,                ($t8)
    syscall 
    li      $v0,                4
    la      $a0,                new_line
    syscall 
    addi    $t7,                $t7,        1
    j       loop

return:
    li      $v0,                4
    la      $a0,                new_line
    syscall 
    lw      $ra,                ($sp)
    addi    $sp,                $sp,        4
    jr      $ra

main:
    lw      $t0,                n
    lw      $t1,                n
    la      $a1,                arr
    jal     print_array

outer_loop:
    addi    $t1,                $t1,        -1
    blt     $t1,                $zero,      exit
    add     $t2,                $zero,      $zero

inner_loop:
    bge     $t2,                $t1,        outer_loop
    sll     $t6,                $t2,        2
    add     $t6,                $t6,        $a1
    lw      $t3,                ($t6)
    addi    $t4,                $t2,        1
    sll     $t6,                $t4,        2
    add     $t6,                $t6,        $a1
    lw      $t5,                ($t6)
    blt     $t5,                $t3,        swap

after_condition:
    addi    $t2,                $t2,        1
    j       inner_loop

swap:
    sll     $t6,                $t4,        2
    add     $t6,                $t6,        $a1
    sw      $t3,                ($t6)
    sll     $t6,                $t2,        2
    add     $t6,                $t6,        $a1
    sw      $t5,                ($t6)
    j       after_condition

exit:
    jal     print_array
    li      $v0,                10                      # Exit the program
    syscall 
