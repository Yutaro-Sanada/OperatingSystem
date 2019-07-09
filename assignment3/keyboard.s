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
	subl	$8, %esp
	calll	_register_kbd_handler
	movl	%eax, -4(%ebp)          ## 4-byte Spill
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	calll	_halt
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	jmp	LBB0_1
	.cfi_endproc
                                        ## -- End function
	.globl	_kbd_handler            ## -- Begin function kbd_handler
	.p2align	4, 0x90
_kbd_handler:                           ## @kbd_handler
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$56, %esp
	movl	$32, (%esp)
	movl	$97, 4(%esp)
	calll	_out8
	movl	$96, (%esp)
	movl	%eax, -16(%ebp)         ## 4-byte Spill
	calll	_in8
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	andl	$127, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movl	$1, %ecx
	cmpl	%eax, %ecx
	jg	LBB1_3
## %bb.1:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	cmpl	$9, %eax
	jg	LBB1_3
## %bb.2:
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movl	_xpos, %ecx
	movl	%eax, (%esp)
	movl	%ecx, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	calll	_print
	movl	%eax, -20(%ebp)         ## 4-byte Spill
	jmp	LBB1_4
LBB1_3:
	xorl	%eax, %eax
	movl	_xpos, %ecx
	movl	$0, (%esp)
	movl	%ecx, 4(%esp)
	movl	$50, 8(%esp)
	movl	$15, 12(%esp)
	movl	%eax, -24(%ebp)         ## 4-byte Spill
	calll	_print
	movl	%eax, -28(%ebp)         ## 4-byte Spill
LBB1_4:
	movl	_xpos, %eax
	addl	$5, %eax
	movl	%eax, _xpos
	movl	-4(%ebp), %eax
	addl	$56, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_out8                   ## -- Begin function out8
	.p2align	4, 0x90
_out8:                                  ## @out8
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	pushl	%esi
	subl	$8, %esp
	.cfi_offset %esi, -12
	movl	12(%ebp), %eax
	movl	8(%ebp), %ecx
	movl	8(%ebp), %edx
	movl	12(%ebp), %esi
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	movl	%esi, %eax
	## InlineAsm Start
	outb	%al, %dx
	## InlineAsm End
	xorl	%eax, %eax
	movl	%ecx, -12(%ebp)         ## 4-byte Spill
	addl	$8, %esp
	popl	%esi
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_in8                    ## -- Begin function in8
	.p2align	4, 0x90
_in8:                                   ## @in8
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%eax, -8(%ebp)          ## 4-byte Spill
	## InlineAsm Start
	movl	$0, %eax
	inb	%dx, %al
	## InlineAsm End
	movl	%eax, -4(%ebp)
	movl	-4(%ebp), %eax
	addl	$8, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_print                  ## -- Begin function print
	.p2align	4, 0x90
_print:                                 ## @print
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	pushl	%ebx
	pushl	%edi
	pushl	%esi
	subl	$36, %esp
	.cfi_offset %esi, -20
	.cfi_offset %edi, -16
	.cfi_offset %ebx, -12
	movl	20(%ebp), %eax
	movl	16(%ebp), %ecx
	movl	12(%ebp), %edx
	movl	8(%ebp), %esi
	movl	$655360, %edi           ## imm = 0xA0000
	movl	%edi, -24(%ebp)
	movl	8(%ebp), %edi
	shll	$2, %edi
	leal	_print.bitmaps, %ebx
	addl	%edi, %ebx
	movl	%ebx, -28(%ebp)
	imull	$320, 16(%ebp), %edi    ## imm = 0x140
	addl	12(%ebp), %edi
	addl	-24(%ebp), %edi
	movl	%edi, -24(%ebp)
	movl	$0, -16(%ebp)
	movl	%eax, -36(%ebp)         ## 4-byte Spill
	movl	%ecx, -40(%ebp)         ## 4-byte Spill
	movl	%edx, -44(%ebp)         ## 4-byte Spill
	movl	%esi, -48(%ebp)         ## 4-byte Spill
LBB4_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB4_3 Depth 2
	cmpl	$8, -16(%ebp)
	jge	LBB4_10
## %bb.2:                               ##   in Loop: Header=BB4_1 Depth=1
	movl	$0, -20(%ebp)
LBB4_3:                                 ##   Parent Loop BB4_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$4, -20(%ebp)
	jge	LBB4_8
## %bb.4:                               ##   in Loop: Header=BB4_3 Depth=2
	movl	-28(%ebp), %eax
	movl	-20(%ebp), %ecx
	movb	(%eax,%ecx), %dl
	movb	%dl, -29(%ebp)
	movsbl	-29(%ebp), %eax
	movl	-16(%ebp), %ecx
                                        ## kill: def $cl killed $ecx
	movl	$128, %esi
	sarl	%cl, %esi
	andl	%esi, %eax
	cmpl	$0, %eax
	je	LBB4_6
## %bb.5:                               ##   in Loop: Header=BB4_3 Depth=2
	movl	20(%ebp), %eax
	movb	%al, %cl
	movl	-24(%ebp), %eax
	movl	-20(%ebp), %edx
	movb	%cl, (%eax,%edx)
LBB4_6:                                 ##   in Loop: Header=BB4_3 Depth=2
	jmp	LBB4_7
LBB4_7:                                 ##   in Loop: Header=BB4_3 Depth=2
	movl	-20(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -20(%ebp)
	jmp	LBB4_3
LBB4_8:                                 ##   in Loop: Header=BB4_1 Depth=1
	movl	-24(%ebp), %eax
	addl	$320, %eax              ## imm = 0x140
	movl	%eax, -24(%ebp)
## %bb.9:                               ##   in Loop: Header=BB4_1 Depth=1
	movl	-16(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -16(%ebp)
	jmp	LBB4_1
LBB4_10:
	xorl	%eax, %eax
	addl	$36, %esp
	popl	%esi
	popl	%edi
	popl	%ebx
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_register_kbd_handler   ## -- Begin function register_kbd_handler
	.p2align	4, 0x90
_register_kbd_handler:                  ## @register_kbd_handler
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$40, %esp
	movl	$32256, %eax            ## imm = 0x7E00
	movl	%eax, -8(%ebp)
	movl	-8(%ebp), %eax
	leal	_kbd_handler, %ecx
	movl	%ecx, (%eax)
	calll	_sti
	movl	$33, (%esp)
	movl	$249, 4(%esp)
	movl	%eax, -12(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	$161, (%esp)
	movl	$255, 4(%esp)
	movl	%eax, -16(%ebp)         ## 4-byte Spill
	calll	_out8
	movl	-4(%ebp), %ecx
	movl	%eax, -20(%ebp)         ## 4-byte Spill
	movl	%ecx, %eax
	addl	$40, %esp
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_sti                    ## -- Begin function sti
	.p2align	4, 0x90
_sti:                                   ## @sti
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	sti
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_cli                    ## -- Begin function cli
	.p2align	4, 0x90
_cli:                                   ## @cli
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	cli
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_halt                   ## -- Begin function halt
	.p2align	4, 0x90
_halt:                                  ## @halt
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	hlt
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.globl	_sti_and_halt           ## -- Begin function sti_and_halt
	.p2align	4, 0x90
_sti_and_halt:                          ## @sti_and_halt
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	## InlineAsm Start
	sti
	hlt
	## InlineAsm End
	xorl	%eax, %eax
	popl	%ebp
	retl
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__data
	.globl	_xpos                   ## @xpos
	.p2align	2
_xpos:
	.long	100                     ## 0x64

_print.bitmaps:                         ## @print.bitmaps
	.ascii	"~\201\201~"
	.ascii	"\000A\377\001"
	.ascii	"\236\222\222\362"
	.ascii	"\222\222\222\376"
	.ascii	"\370\b\b\377"
	.ascii	"\362\222\222\236"
	.ascii	"\376\022\022\036"
	.ascii	"\340\200\200\376"
	.ascii	"\376\222\222\376"
	.ascii	"\360\220\220\376"
	.space	4


.subsections_via_symbols
