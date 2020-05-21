format ELF64
public _start

	bs_char rb 1

_start:
	mov   rax, '@'
	call _print_char
	call _new_line

	jmp _exit

_print_char:
	push rax
	push rbx
	push rcx
	push rdx
	mov  [bs_char], al
	mov  rax, 4
	mov  rbx, 1
	mov  rcx, bs_char
	mov  rdx, 1
	int  0x80
	pop  rdx
	pop  rcx
	pop  rbx
	pop  rax
	ret
	
_exit:
	mov rax, 1
	xor rbx, rbx
	int 0x80
