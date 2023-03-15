bucket_sort(float*, int):
        addiu   $sp,$sp,-104
        sw      $fp,100($sp)
        sw      $18,96($sp)
        sw      $17,92($sp)
        sw      $16,88($sp)
        move    $fp,$sp
        sw      $4,104($fp)
        sw      $5,108($fp)
        move    $4,$sp
        move    $18,$4
        li      $4,10                 # 0xa
        sw      $4,28($fp)
        lw      $4,108($fp)
        addiu   $5,$4,-1
        sw      $5,32($fp)
        move    $4,$5
        addiu   $4,$4,1
        move    $15,$4
        move    $14,$0
        srl     $4,$15,27
        sll     $2,$14,5
        or      $2,$4,$2
        sll     $3,$15,5
        move    $2,$5
        addiu   $2,$2,1
        sll     $4,$2,2
        move    $2,$5
        addiu   $2,$2,1
        move    $17,$2
        move    $16,$0
        move    $3,$17
        move    $2,$16
        srl     $14,$3,30
        sll     $6,$2,2
        or      $6,$14,$6
        sll     $7,$3,2
        move    $3,$7
        move    $2,$6
        addu    $7,$3,$17
        sltu    $14,$7,$3
        addu    $6,$2,$16
        addu    $2,$14,$6
        move    $6,$2
        move    $3,$7
        move    $2,$6
        srl     $6,$3,26
        sll     $12,$2,6
        or      $12,$6,$12
        sll     $13,$3,6
        move    $3,$13
        move    $2,$12
        move    $2,$5
        addiu   $3,$2,1
        move    $2,$3
        sll     $2,$2,2
        addu    $2,$2,$3
        sll     $2,$2,3
        move    $2,$5
        addiu   $2,$2,1
        move    $25,$2
        move    $24,$0
        move    $3,$25
        move    $2,$24
        srl     $6,$3,30
        sll     $10,$2,2
        or      $10,$6,$10
        sll     $11,$3,2
        move    $3,$11
        move    $2,$10
        addu    $7,$3,$25
        sltu    $10,$7,$3
        addu    $6,$2,$24
        addu    $2,$10,$6
        move    $6,$2
        move    $3,$7
        move    $2,$6
        srl     $6,$3,26
        sll     $8,$2,6
        or      $8,$6,$8
        sll     $9,$3,6
        move    $3,$9
        move    $2,$8
        move    $2,$5
        addiu   $3,$2,1
        move    $2,$3
        sll     $2,$2,2
        addu    $2,$2,$3
        sll     $2,$2,3
        addiu   $2,$2,7
        srl     $2,$2,3
        sll     $2,$2,3
        subu    $sp,$sp,$2
        move    $2,$sp
        addiu   $2,$2,3
        srl     $2,$2,2
        sll     $2,$2,2
        sw      $2,36($fp)
        sw      $0,48($fp)
        sw      $0,52($fp)
        sw      $0,56($fp)
        sw      $0,60($fp)
        sw      $0,64($fp)
        sw      $0,68($fp)
        sw      $0,72($fp)
        sw      $0,76($fp)
        sw      $0,80($fp)
        sw      $0,84($fp)
        sw      $0,20($fp)
.L3:
        lw      $3,20($fp)
        lw      $2,108($fp)
        slt     $2,$3,$2
        beq     $2,$0,.L2
        nop

        lw      $2,20($fp)
        sll     $2,$2,2
        lw      $3,104($fp)
        addu    $2,$3,$2
        lwc1    $f2,0($2)
        lwc1    $f0,%gp_rel(.LC1)($28)
        mul.s   $f0,$f2,$f0
        trunc.w.s $f0,$f0
        mfc1    $2,$f0
        sw      $2,40($fp)
        lw      $2,20($fp)
        sll     $2,$2,2
        lw      $3,104($fp)
        addu    $3,$3,$2
        srl     $6,$4,2
        lw      $2,40($fp)
        sll     $2,$2,2
        addu    $2,$fp,$2
        lw      $2,48($2)
        lwc1    $f0,0($3)
        lw      $3,36($fp)
        lw      $5,40($fp)
        mul     $5,$6,$5
        addu    $2,$5,$2
        sll     $2,$2,2
        addu    $2,$3,$2
        swc1    $f0,0($2)
        lw      $2,40($fp)
        sll     $2,$2,2
        addu    $2,$fp,$2
        lw      $2,48($2)
        addiu   $3,$2,1
        lw      $2,40($fp)
        sll     $2,$2,2
        addu    $2,$fp,$2
        sw      $3,48($2)
        lw      $2,20($fp)
        addiu   $2,$2,1
        sw      $2,20($fp)
        b       .L3
        nop

.L2:
        sw      $0,16($fp)
.L10:
        lw      $2,16($fp)
        slt     $2,$2,10
        beq     $2,$0,.L4
        nop

        li      $2,1                        # 0x1
        sw      $2,12($fp)
.L9:
        lw      $2,16($fp)
        sll     $2,$2,2
        addu    $2,$fp,$2
        lw      $2,48($2)
        lw      $3,12($fp)
        slt     $2,$3,$2
        beq     $2,$0,.L5
        nop

        srl     $5,$4,2
        lw      $3,36($fp)
        lw      $2,16($fp)
        mul     $5,$5,$2
        lw      $2,12($fp)
        addu    $2,$5,$2
        sll     $2,$2,2
        addu    $2,$3,$2
        lwc1    $f0,0($2)
        swc1    $f0,44($fp)
        lw      $2,12($fp)
        addiu   $2,$2,-1
        sw      $2,8($fp)
.L8:
        lw      $2,8($fp)
        bltz    $2,.L6
        nop

        srl     $5,$4,2
        lw      $3,36($fp)
        lw      $2,16($fp)
        mul     $5,$5,$2
        lw      $2,8($fp)
        addu    $2,$5,$2
        sll     $2,$2,2
        addu    $2,$3,$2
        lwc1    $f0,0($2)
        li      $2,1                        # 0x1
        lwc1    $f2,44($fp)
        c.lt.s  $fcc0,$f2,$f0
        bc1t    $fcc0,.L7
        nop

        move    $2,$0
.L7:
        andi    $2,$2,0x00ff
        xori    $2,$2,0x1
        andi    $2,$2,0x00ff
        bne     $2,$0,.L6
        nop

        srl     $7,$4,2
        srl     $6,$4,2
        lw      $2,8($fp)
        addiu   $2,$2,1
        lw      $5,36($fp)
        lw      $3,16($fp)
        mul     $7,$7,$3
        lw      $3,8($fp)
        addu    $3,$7,$3
        sll     $3,$3,2
        addu    $3,$5,$3
        lwc1    $f0,0($3)
        lw      $3,36($fp)
        lw      $5,16($fp)
        mul     $5,$6,$5
        addu    $2,$5,$2
        sll     $2,$2,2
        addu    $2,$3,$2
        swc1    $f0,0($2)
        lw      $2,8($fp)
        addiu   $2,$2,-1
        sw      $2,8($fp)
        b       .L8
        nop

.L6:
        srl     $6,$4,2
        lw      $2,8($fp)
        addiu   $2,$2,1
        lw      $3,36($fp)
        lw      $5,16($fp)
        mul     $5,$6,$5
        addu    $2,$5,$2
        sll     $2,$2,2
        addu    $2,$3,$2
        lwc1    $f0,44($fp)
        swc1    $f0,0($2)
        lw      $2,12($fp)
        addiu   $2,$2,1
        sw      $2,12($fp)
        b       .L9
        nop

.L5:
        lw      $2,16($fp)
        addiu   $2,$2,1
        sw      $2,16($fp)
        b       .L10
        nop

.L4:
        sw      $0,4($fp)
        sw      $0,0($fp)
.L14:
        lw      $2,0($fp)
        slt     $2,$2,10
        beq     $2,$0,.L11
        nop

        sw      $0,24($fp)
.L13:
        lw      $2,0($fp)
        sll     $2,$2,2
        addu    $2,$fp,$2
        lw      $2,48($2)
        lw      $3,24($fp)
        slt     $2,$3,$2
        beq     $2,$0,.L12
        nop

        srl     $6,$4,2
        lw      $2,4($fp)
        sll     $2,$2,2
        lw      $3,104($fp)
        addu    $2,$3,$2
        lw      $5,36($fp)
        lw      $3,0($fp)
        mul     $6,$6,$3
        lw      $3,24($fp)
        addu    $3,$6,$3
        sll     $3,$3,2
        addu    $3,$5,$3
        lwc1    $f0,0($3)
        swc1    $f0,0($2)
        lw      $2,4($fp)
        addiu   $2,$2,1
        sw      $2,4($fp)
        lw      $2,24($fp)
        addiu   $2,$2,1
        sw      $2,24($fp)
        b       .L13
        nop

.L12:
        lw      $2,0($fp)
        addiu   $2,$2,1
        sw      $2,0($fp)
        b       .L14
        nop

.L11:
        move    $sp,$18
        nop
        move    $sp,$fp
        lw      $fp,100($sp)
        lw      $18,96($sp)
        lw      $17,92($sp)
        lw      $16,88($sp)
        addiu   $sp,$sp,104
        jr      $31
        nop

.LC2:
        .ascii  "Unsorted array:\000"
.LC3:
        .ascii  "%f \000"
.LC4:
        .ascii  "Sorted array:\000"
.LC0:
        .word   1036831949
        .word   1061997773
        .word   1050253722
        .word   1058642330
        .word   1063675494
        .word   1045220557
        .word   1053609165
        .word   1060320051
        .word   1056964608
main:
        addiu   $sp,$sp,-72
        sw      $31,68($sp)
        sw      $fp,64($sp)
        move    $fp,$sp
        lui     $2,%hi(.LC0)
        lw      $10,%lo(.LC0)($2)
        addiu   $3,$2,%lo(.LC0)
        lw      $9,4($3)
        addiu   $3,$2,%lo(.LC0)
        lw      $8,8($3)
        addiu   $3,$2,%lo(.LC0)
        lw      $7,12($3)
        addiu   $3,$2,%lo(.LC0)
        lw      $6,16($3)
        addiu   $3,$2,%lo(.LC0)
        lw      $5,20($3)
        addiu   $3,$2,%lo(.LC0)
        lw      $4,24($3)
        addiu   $3,$2,%lo(.LC0)
        lw      $3,28($3)
        addiu   $2,$2,%lo(.LC0)
        lw      $2,32($2)
        sw      $10,28($fp)
        sw      $9,32($fp)
        sw      $8,36($fp)
        sw      $7,40($fp)
        sw      $6,44($fp)
        sw      $5,48($fp)
        sw      $4,52($fp)
        sw      $3,56($fp)
        sw      $2,60($fp)
        li      $2,9                        # 0x9
        sw      $2,24($fp)
        lui     $2,%hi(.LC2)
        addiu   $4,$2,%lo(.LC2)
        jal     puts
        nop

        sw      $0,16($fp)
.L17:
        lw      $3,16($fp)
        lw      $2,24($fp)
        slt     $2,$3,$2
        beq     $2,$0,.L16
        nop

        lw      $2,16($fp)
        sll     $2,$2,2
        addiu   $3,$fp,16
        addu    $2,$3,$2
        lwc1    $f0,12($2)
        cvt.d.s $f0,$f0
        mfc1    $7,$f0
        mfhc1   $6,$f0
        lui     $2,%hi(.LC3)
        addiu   $4,$2,%lo(.LC3)
        jal     printf
        nop

        lw      $2,16($fp)
        addiu   $2,$2,1
        sw      $2,16($fp)
        b       .L17
        nop

.L16:
        li      $4,10                 # 0xa
        jal     putchar
        nop

        addiu   $2,$fp,28
        lw      $5,24($fp)
        move    $4,$2
        jal     bucket_sort(float*, int)
        nop

        lui     $2,%hi(.LC4)
        addiu   $4,$2,%lo(.LC4)
        jal     puts
        nop

        sw      $0,20($fp)
.L19:
        lw      $3,20($fp)
        lw      $2,24($fp)
        slt     $2,$3,$2
        beq     $2,$0,.L18
        nop

        lw      $2,20($fp)
        sll     $2,$2,2
        addiu   $3,$fp,16
        addu    $2,$3,$2
        lwc1    $f0,12($2)
        cvt.d.s $f0,$f0
        mfc1    $7,$f0
        mfhc1   $6,$f0
        lui     $2,%hi(.LC3)
        addiu   $4,$2,%lo(.LC3)
        jal     printf
        nop

        lw      $2,20($fp)
        addiu   $2,$2,1
        sw      $2,20($fp)
        b       .L19
        nop

.L18:
        li      $4,10                 # 0xa
        jal     putchar
        nop

        move    $2,$0
        move    $sp,$fp
        lw      $31,68($sp)
        lw      $fp,64($sp)
        addiu   $sp,$sp,72
        jr      $31
        nop

.LC1:
        .word   1092616192