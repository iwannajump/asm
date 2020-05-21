format ELF64
public _start

	bs_char rb 1

_start:
	mov rax, 'A'
	call _print_char
	mov rax, 'S'
	call _print_char
	mov rax, 'S'
	call _print_char
	jmp _exit

_print_char:
	mov [bs_char], al
	mov rax, 4
	mov rbx, 1
	mov rcx, bs_char
	mov rdx, 1
	int 0x80
	ret

_exit:
	mov rax, 1
	xor rbx, rbx
	int 0x80
