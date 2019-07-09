.org 0x8200

	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.globl	_boot2                  ## -- Begin function boot2
	.p2align	4, 0x90
_boot2:                                 ## @boot2
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$24, %esp
	movl	$655360, %eax           ## imm = 0xA0000
	movl	%eax, -8(%ebp)
	movl	$10, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	$0, -4(%ebp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$1280, -4(%ebp)         ## imm = 0x500
	jge	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-8(%ebp), %eax
	addl	$80, %eax
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	movb	$15, (%eax)
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-4(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -4(%ebp)
	jmp	LBB0_1
LBB0_4:
	calll	_halt
	addl	$24, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function halt
_halt:                                  ## @halt
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	jmp	LBB1_1
LBB1_1:                                 ## =>This Inner Loop Header: Depth=1
	jmp	LBB1_1
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
