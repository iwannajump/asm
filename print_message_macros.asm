format ELF64
public _start

section '_data' writable
	asm_message_1 db "assembly_test_string", 	0xA, 0
								; 0xA - print new line

	asm_message_2 db "assembly_test_string 1", 	0xA, 0
								; 0 - \0

section '_text' executable
	_start:
		mov rax, asm_message_1
		call 	_print_string

		mov rax, asm_message_2
		call 	_print_string

		jmp _exit 					; jmp instead of call to clear stack

section '_print_string' executable
	_print_string:
		push rax					; push value to the stack
		push rbx					; push value to the stack
		push rcx					; push value to the stack
		push rdx					; push value to the stack
		mov  rcx, rax				; move pointer to first symbol of message to RAX
		call _length_string
		mov rdx, rax 				; RAX contains result of _length_string
		mov rax, 4					; 4 - write
		xor rbx, rbx				; 1 - stdout
		inc rbx
		int 0x80					; call system kernel
		pop rdx						; get value from the stack
		pop rcx						; get value from the stack
		pop rbx						; get value from the stack
		pop rax						; get value from the stack
		ret

section '_length_string' executable
	_length_string:
		push rdx
		xor rdx, rdx				; mov RDX, 0 
		._next_iteration:			; internal procedure
			cmp [rax+rdx], byte 0	; RAX - message, RDX - message length
			je .close				; if cmp = true then 
			inc rdx					; get next char
			jmp ._next_iteration	; goto _next_iteration
		.close:
			mov rax, rdx			; push result of _next_iteration to RAX
			pop rdx					; get value from the stack
			ret 					; end of macros

_exit:
		mov rax, 1 					; 1 - exit
		mov rbx, 0 					; 0 - return
		int 0x80