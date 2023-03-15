.data
    input: .float 5.2, 8.9, 3.1, 1.5, 9.3, 6.8, 2.7, 7.6, 4.4
    bucket1: .space 36
    bucket2: .space 36
    bucket3: .space 36
    bucket4: .space 36
    output: .space 36

.text
    .globl main
    .ent main
main:
    # Initialize the buckets
    li $t0, 0
    li $t1, 9
    la $t2, bucket1
    li $t3, 9
    init_loop1:
        swc1 $f0, 0($t2)
        addiu $t2, $t2, 4
        addiu $t0, $t0, 1
        bne $t0, $t1, init_loop1
    la $t2, bucket2
    init_loop2:
        swc1 $f0, 0($t2)
        addiu $t2, $t2, 4
        addiu $t0, $t0, 1
        bne $t0, $t3, init_loop2
    la $t2, bucket3
    init_loop3:
        swc1 $f0, 0($t2)
        addiu $t2, $t2, 4
        addiu $t0, $t0, 1
        bne $t0, $t3, init_loop3
    la $t2, bucket4
    init_loop4:
        swc1 $f0, 0($t2)
        addiu $t2, $t2, 4
        addiu $t0, $t0, 1
        bne $t0, $t3, init_loop4
    
    # Divide the input into buckets
    li $t4, 9
    la $t5, input
    la $t6, bucket1
    li $t7, 0x40000000 # This will be used to divide the numbers into buckets
    div_loop:
        lwc1 $f0, 0($t5)
        addiu $t5, $t5, 4
        c.lt.s $f0, $f31
        bc1t bucket1_loop
        c.lt.s $f0, $f7
        bc1t bucket2_loop
        c.lt.s $f0, $f15
        bc1t bucket3_loop
        bc1t bucket4_loop
        j div_loop
    bucket1_loop:
        lw $t8, 0($t6)
        swc1 $f0, ($t8)
        addiu $t8, $t8, 4
        sw $t8, 0($t6)
        j div_loop
    bucket2_loop:
        # li $t9, 36
        # addu $t9, $t9, $t6
        # lw $t8, 0($t9)
        lw $t8, 0($t6+36)
        swc1 $f0, ($t8)
        addiu $t8, $t8, 4
        sw $t8, 0($t6+36)
        j div_loop
    bucket3_loop:
        # addi $t7, $t6, 72
        # lw $t8, 0($t7)
        lw $t8, 0($t6)+72
        swc1 $f0, ($t8)
        # addiu $t8, $t8, 4
        sw $t8, 0($t6+72)
        sw $t8, 0($t7)
        j div_loop
    bucket4_loop:
        addi $t7, $t6, 108
        lw $t8, 0($t7)
        swc1 $f0, ($t8)
        addiu $t8, $t8, 4
        addi $t7, $t6, 108
        sw $t8, 0($t7)
        j div_loop

    # Sort the individual buckets
    li $t9, 9
    li $t10, 4
    la $t6, bucket1
    la $t11, output
    sort_loop1:
        li $t12, 0
        la $t13, bucket1
        inner_loop1:
            lw $t14, 0($t13)
            beq $t14, $t9, outer_loop1
            lwc1 $f0, ($t14)
            addiu $t13, $t13, $t10
            lw $t15, 0($t13)
            beq $t15, $t9, outer_loop1
            lwc1 $f1, ($t15)
            c.lt.s $f0, $f1
            bc1t swap1
            swc1 $f1, ($t11)
            addiu $t15, $t15, 4
            sw $t15, 0($t13)
            j no_swap1
        swap1:
            swc1 $f0, ($t11)
            addiu $t14, $t14, 4
            sw $t14, 0($t13+4)
        no_swap1:
            addiu $t12, $t12, 1
            bne $t12, $t9, inner_loop1
        addiu $t11, $t11, 36
        addiu $t6, $t6, 36
        j sort_loop1
    outer_loop1:

    la $t6, bucket2
    la $t11, output+36
    sort_loop2:
        li $t12, 0
        la $t13, bucket2
        inner_loop2:
            lw $t14, 0($t13)
            beq $t14, $t9, outer_loop2
            lwc1 $f0, ($t14)
            addiu $t13, $t13, $t10
            lw $t15, 0($t13)
            beq $t15, $t9, outer_loop2
            lwc1 $f1, ($t15)
            c.lt.s $f0, $f1
            bc1t swap2
            swc1 $f1, ($t11)
            addiu $t15, $t15, 4
            sw $t15, 0($t13)
            j no_swap2
        swap2:
            swc1 $f0, ($t11)
            addiu $t14, $t14, 4
            sw $t14, 0($t13+4)
        no_swap2:
            addiu $t12, $t12, 1
            bne $t12, $t9, inner_loop2
        addiu $t11, $t11, 36
        addiu $t6, $t6, 36
        j sort_loop2
        outer_loop2:
            la $t6, bucket3
            la $t11, output+72
    sort_loop3:
        li $t12, 0
        la $t13, bucket3
        inner_loop3:
            lw $t14, 0($t13)
            beq $t14, $t9, outer_loop3
            lwc1 $f0, ($t14)
            addiu $t13, $t13, $t10
            lw $t15, 0($t13)
            beq $t15, $t9, outer_loop3
            lwc1 $f1, ($t15)
            c.lt.s $f0, $f1
            bc1t swap3
            swc1 $f1, ($t11)
            addiu $t15, $t15, 4
            sw $t15, 0($t13)
            j no_swap3
        swap3:
            swc1 $f0, ($t11)
            addiu $t14, $t14, 4
            sw $t14, 0($t13+4)
        no_swap3:
            addiu $t12, $t12, 1
            bne $t12, $t9, inner_loop3
        addiu $t11, $t11, 36
        addiu $t6, $t6, 36
        j sort_loop3
    outer_loop3:

    # Merge the sorted buckets into the output array
    la $t6, output
    la $t7, bucket1
    la $t8, bucket2
    la $t9, bucket3
    la $t10, output
    li $t11, 0
    merge_loop:
        lw $t12, 0($t7)
        beq $t12, $t6, merge_bucket2
        lw $t13, 0($t8)
        beq $t13, $t6, merge_bucket3
        lwc1 $f0, ($t12)
        lwc1 $f1, ($t13)
        c.lt.s $f0, $f1
        bc1t merge_bucket1
        swc1 $f1, ($t10)
        addiu $t8, $t8, 4
        sw $t8, 0($t6+108)
        j no_merge
    merge_bucket1:
        swc1 $f0, ($t10)
        addiu $t7, $t7, 4
        sw $t7, 0($t6+36)
        j no_merge
    merge_bucket2:
        beq $t13, $t6, merge_bucket3
        lwc1 $f1, ($t13)
        swc1 $f1, ($t10)
        addiu $t8, $t8, 4
        sw $t8, 0($t6+108)
        j no_merge
    merge_bucket3:
        lwc1 $f1, ($t9)
        swc1 $f1, ($t10)
        addiu $t9, $t9, 4
        sw $t9, 0($t6+72)
        j no_merge
    no_merge:
        addiu $t10, $t10, 4
        addiu $t11, $t11, 1
        bne $t11, $t5, merge
    # Clear the buckets for next use
    li $t5, 32
    la $t6, bucket1
    la $t7, bucket2
    la $t8, bucket3
    clear_loop:
        sw $t6, 0($t6)
        sw $t7, 0($t7)
        sw $t8, 0($t8)
        addiu $t6, $t6, 4
        addiu $t7, $t7, 4
        addiu $t8, $t8, 4
        addiu $t5, $t5, -1
        bne $t5, $0, clear_loop

    # Exit the program
    li $v0, 10
    syscall

                



