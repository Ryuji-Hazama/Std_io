section .text
	global std_in
	global std_out

std_in:
	; - - - - - - - - - - - ;
	; Reserve buffer before ;
	; call this function    ;
	; - - - - - - - - - - - ;

section .text
	mov rax, 0		; System call 0 = sys_read
	mov rdi, 0		; File descriptor 0 = stdin
	syscall

	mov rdx, rax		; Move byte count to RDX
	ret

std_out:
	; - - - - - - - - - - - - - - -;
	; Before call this function:   ;
	; store string pointer to RSI, ;
	; and                          ;
	; store byte length to RDX     ;
	; - - - - - - - - - - - - - - -;

	mov rax, 1		; System call 1 = sys_write
	mov rdi, 1		; File sexcriptor 1 = stdout
	syscall
	ret
