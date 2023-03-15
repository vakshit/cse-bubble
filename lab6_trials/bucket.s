.file	1 "bucket.c"
# .section .mdebug.abi32
# .previous
# .nan	legacy
# .module	fp=xx
# .module	nooddspreg
# .abicalls
.text
# .rdata
.align	2
$LC1:
	# .ascii	"%f \000"
	.text
	.align	2
	.globl	printArray
	.set	nomips16
	.set	nomicromips
	.ent	printArray
	# .type	printArray, @function
printArray:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	# lui	$28,%hi(__gnu_local_gp)
	# addiu	$28,$28,%lo(__gnu_local_gp)
	# .cprestore	16
	sw	$4,40($fp)
	sw	$5,44($fp)
	sw	$0,28($fp)
	.option	pic0
	b	$L2
	nop

	.option	pic2
$L3:
	lw	$2,28($fp)
	sll	$2,$2,2
	lw	$3,40($fp)
	addu	$2,$3,$2
	lwc1	$f0,0($2)
	cvt.d.s	$f0,$f0
	mfc1	$7,$f0
	mfhc1	$6,$f0
	lui	$2,%hi($LC1)
	addiu	$4,$2,%lo($LC1)
	lw	$2,%call16(printf)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,printf
1:	jalr	$25
	nop

	lw	$28,16($fp)
	lw	$2,28($fp)
	addiu	$2,$2,1
	sw	$2,28($fp)
$L2:
	lw	$3,28($fp)
	lw	$2,44($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L3
	nop

	li	$4,10			# 0xa
	lw	$2,%call16(putchar)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,putchar
1:	jalr	$25
	nop

	lw	$28,16($fp)
	nop
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	printArray
	.size	printArray, .-printArray
	.rdata
	.align	2
$LC2:
	.ascii	"Bucket overflow error\000"
	.text
	.align	2
	.globl	bucketSort
	.set	nomips16
	.set	nomicromips
	.ent	bucketSort
	# .type	bucketSort, @function
bucketSort:
	.frame	$fp,496,$31		# vars= 464, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-496
	sw	$31,492($sp)
	sw	$fp,488($sp)
	move	$fp,$sp
	# lui	$28,%hi(__gnu_local_gp)
	# addiu	$28,$28,%lo(__gnu_local_gp)
	# .cprestore	16
	sw	$4,28($fp)
	sw	$5,500($fp)
	lw	$2,%got(__stack_chk_guard)($28)
	lw	$2,0($2)
	sw	$2,484($fp)
	li	$2,10			# 0xa
	sw	$2,72($fp)
	sw	$0,32($fp)
	.option	pic0
	b	$L5
	nop

	.option	pic2
$L8:
	sw	$0,36($fp)
	.option	pic0
	b	$L6
	nop

	.option	pic2
$L7:
	lw	$3,32($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,36($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	sw	$0,-404($2)
	lw	$2,36($fp)
	addiu	$2,$2,1
	sw	$2,36($fp)
$L6:
	lw	$2,36($fp)
	slt	$2,$2,10
	bne	$2,$0,$L7
	nop

	lw	$2,32($fp)
	addiu	$2,$2,1
	sw	$2,32($fp)
$L5:
	lw	$3,32($fp)
	lw	$2,72($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L8
	nop

	sw	$0,40($fp)
	.option	pic0
	b	$L9
	nop

	.option	pic2
$L15:
	lw	$2,40($fp)
	sll	$2,$2,2
	lw	$3,28($fp)
	addu	$2,$3,$2
	lwc1	$f2,0($2)
	lw	$2,72($fp)
	mtc1	$2,$f0
	cvt.s.w	$f0,$f0
	mul.s	$f0,$f2,$f0
	trunc.w.s $f0,$f0
	mfc1	$2,$f0
	sw	$2,80($fp)
	sw	$0,44($fp)
	.option	pic0
	b	$L10
	nop

	.option	pic2
$L12:
	lw	$2,44($fp)
	addiu	$2,$2,1
	sw	$2,44($fp)
$L10:
	lw	$2,44($fp)
	slt	$2,$2,10
	beq	$2,$0,$L11
	nop

	lw	$3,80($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,44($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	lwc1	$f0,-404($2)
	mtc1	$0,$f2
	c.eq.s	$fcc0,$f0,$f2
	bc1f	$fcc0,$L12
	nop

$L11:
	lw	$2,44($fp)
	slt	$2,$2,10
	beq	$2,$0,$L13
	nop

	lw	$2,40($fp)
	sll	$2,$2,2
	lw	$3,28($fp)
	addu	$2,$3,$2
	lwc1	$f0,0($2)
	lw	$3,80($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,44($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	swc1	$f0,-404($2)
	.option	pic0
	b	$L29
	nop

	.option	pic2
$L13:
	lui	$2,%hi($LC2)
	addiu	$4,$2,%lo($LC2)
	lw	$2,%call16(puts)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,puts
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$4,1			# 0x1
	lw	$2,%call16(exit)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,exit
1:	jalr	$25
	nop

$L29:
	lw	$2,40($fp)
	addiu	$2,$2,1
	sw	$2,40($fp)
$L9:
	lw	$3,40($fp)
	lw	$2,500($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L15
	nop

	sw	$0,48($fp)
	.option	pic0
	b	$L16
	nop

	.option	pic2
$L22:
	li	$2,1			# 0x1
	sw	$2,52($fp)
	.option	pic0
	b	$L17
	nop

	.option	pic2
$L21:
	lw	$3,48($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,52($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	lwc1	$f0,-404($2)
	swc1	$f0,76($fp)
	lw	$2,52($fp)
	addiu	$2,$2,-1
	sw	$2,56($fp)
	.option	pic0
	b	$L18
	nop

	.option	pic2
$L20:
	lw	$2,56($fp)
	addiu	$4,$2,1
	lw	$3,48($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,56($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	lwc1	$f0,-404($2)
	lw	$3,48($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$2,$4
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	swc1	$f0,-404($2)
	lw	$2,56($fp)
	addiu	$2,$2,-1
	sw	$2,56($fp)
$L18:
	lw	$2,56($fp)
	bltz	$2,$L19
	nop

	lw	$3,48($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,56($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	lwc1	$f0,-404($2)
	lwc1	$f2,76($fp)
	c.lt.s	$fcc1,$f2,$f0
	bc1t	$fcc1,$L20
	nop

$L19:
	lw	$2,56($fp)
	addiu	$4,$2,1
	lw	$3,48($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	addu	$2,$2,$4
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	lwc1	$f0,76($fp)
	swc1	$f0,-404($2)
	lw	$2,52($fp)
	addiu	$2,$2,1
	sw	$2,52($fp)
$L17:
	lw	$2,52($fp)
	slt	$2,$2,10
	bne	$2,$0,$L21
	nop

	lw	$2,48($fp)
	addiu	$2,$2,1
	sw	$2,48($fp)
$L16:
	lw	$3,48($fp)
	lw	$2,72($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L22
	nop

	sw	$0,60($fp)
	sw	$0,64($fp)
	.option	pic0
	b	$L23
	nop

	.option	pic2
$L27:
	sw	$0,68($fp)
	.option	pic0
	b	$L24
	nop

	.option	pic2
$L26:
	lw	$3,64($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,68($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	lwc1	$f0,-404($2)
	mtc1	$0,$f2
	c.eq.s	$fcc2,$f0,$f2
	bc1t	$fcc2,$L25
	nop

	lw	$2,60($fp)
	sll	$2,$2,2
	lw	$3,28($fp)
	addu	$4,$3,$2
	lw	$3,64($fp)
	move	$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,1
	lw	$3,68($fp)
	addu	$2,$2,$3
	sll	$2,$2,2
	addiu	$3,$fp,488
	addu	$2,$3,$2
	lwc1	$f0,-404($2)
	swc1	$f0,0($4)
	lw	$2,60($fp)
	addiu	$2,$2,1
	sw	$2,60($fp)
$L25:
	lw	$2,68($fp)
	addiu	$2,$2,1
	sw	$2,68($fp)
$L24:
	lw	$2,68($fp)
	slt	$2,$2,10
	bne	$2,$0,$L26
	nop

	lw	$2,64($fp)
	addiu	$2,$2,1
	sw	$2,64($fp)
$L23:
	lw	$3,64($fp)
	lw	$2,72($fp)
	slt	$2,$3,$2
	bne	$2,$0,$L27
	nop

	nop
	lw	$2,%got(__stack_chk_guard)($28)
	lw	$3,484($fp)
	lw	$2,0($2)
	beq	$3,$2,$L28
	nop

	lw	$2,%call16(__stack_chk_fail)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,__stack_chk_fail
1:	jalr	$25
	nop

$L28:
	move	$sp,$fp
	lw	$31,492($sp)
	lw	$fp,488($sp)
	addiu	$sp,$sp,496
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	bucketSort
	.size	bucketSort, .-bucketSort
	.rdata
	.align	2
$LC3:
	.ascii	"Before sorting:\000"
	.align	2
$LC4:
	.ascii	"After sorting:\000"
	.align	2
$LC0:
	.word	1061326684
	.word	1054951342
	.word	1039516303
	.word	1063172178
	.word	1051260355
	.word	1059816735
	.word	1063843267
	.word	1057803469
	.word	1049582633
	.word	1058642330
	.text
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	# .type	main, @function
main:
	.frame	$fp,80,$31		# vars= 48, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-80
	sw	$31,76($sp)
	sw	$fp,72($sp)
	move	$fp,$sp
	# lui	$28,%hi(__gnu_local_gp)
	# addiu	$28,$28,%lo(__gnu_local_gp)
	# .cprestore	16
	lw	$2,%got(__stack_chk_guard)($28)
	lw	$2,0($2)
	sw	$2,68($fp)
	lui	$2,%hi($LC0)
	addiu	$4,$fp,28
	addiu	$2,$2,%lo($LC0)
	li	$3,40			# 0x28
	move	$6,$3
	move	$5,$2
	lw	$2,%call16(memcpy)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,memcpy
1:	jalr	$25
	nop

	lw	$28,16($fp)
	li	$2,10			# 0xa
	sw	$2,24($fp)
	lui	$2,%hi($LC3)
	addiu	$4,$2,%lo($LC3)
	lw	$2,%call16(puts)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,puts
1:	jalr	$25
	nop

	lw	$28,16($fp)
	addiu	$2,$fp,28
	lw	$5,24($fp)
	move	$4,$2
	.option	pic0
	jal	printArray
	nop

	.option	pic2
	lw	$28,16($fp)
	addiu	$2,$fp,28
	lw	$5,24($fp)
	move	$4,$2
	.option	pic0
	jal	bucketSort
	nop

	.option	pic2
	lw	$28,16($fp)
	lui	$2,%hi($LC4)
	addiu	$4,$2,%lo($LC4)
	lw	$2,%call16(puts)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,puts
1:	jalr	$25
	nop

	lw	$28,16($fp)
	addiu	$2,$fp,28
	lw	$5,24($fp)
	move	$4,$2
	.option	pic0
	jal	printArray
	nop

	.option	pic2
	lw	$28,16($fp)
	move	$2,$0
	move	$4,$2
	lw	$2,%got(__stack_chk_guard)($28)
	lw	$3,68($fp)
	lw	$2,0($2)
	beq	$3,$2,$L32
	nop

	lw	$2,%call16(__stack_chk_fail)($28)
	move	$25,$2
	.reloc	1f,R_MIPS_JALR,__stack_chk_fail
1:	jalr	$25
	nop

$L32:
	move	$2,$4
	move	$sp,$fp
	lw	$31,76($sp)
	lw	$fp,72($sp)
	addiu	$sp,$sp,80
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0"
